Return-Path: <linux-kselftest+bounces-3202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAD831BB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 15:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E11C20B6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB531DA2B;
	Thu, 18 Jan 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2s3Dih+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A63646;
	Thu, 18 Jan 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589179; cv=none; b=Abf0YrfiSBgKV8ysXnu6Cab7IzPelj0TUC/oy/CTFbk0iChOtu/KX3JvJtzzJ9QSej8zv5JsBROnXI3PtPVLyuZEftdhx0oBuo9K/Oxv5WXiULwRDaGL8jcT85/l4Nuzq9fLVO1Q19ADBDaHrDmL74Qru+FzE2CEjItYdzBoPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589179; c=relaxed/simple;
	bh=V/rb3e7RICwYcaa6sGQk5hX7onXeunnOrGGXPUjSP4s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Message-ID:In-Reply-To:References:Subject:Mime-Version:
	 Content-Type:Content-Transfer-Encoding; b=JbI01cXbPwgIwxKVY3BcvNhB15Yrk76nvgh9GDAKJGUsrazDTU46bdMOOES6YI3QZlU+3amiA2qyGSLDk3L8RNXajmzr3MXepSbifd/HbSAnZUD7qFoRO5a4hozTez7E6893cvZ+cu2e63bBJEBziaovkW+GnE3uZ9O3f3OYtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2s3Dih+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68192840641so2338746d6.1;
        Thu, 18 Jan 2024 06:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705589177; x=1706193977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/rb3e7RICwYcaa6sGQk5hX7onXeunnOrGGXPUjSP4s=;
        b=b2s3Dih+kRIgNm+BIW8vVCPxX42jWdNMQLlFDCtbcXwUZA9gS/B5PET0r40/8yIGQu
         mm10HhoDzSj/cgqHMwuXoYQX853qJgiMEmSZ9vnQYFoainGHwQp2Pogre0zPjBAezzhk
         90tqPPm0oIcT+LfdosPSfcwrkvv2+4NgNkejyqOqdW3o9lERHDLp1wF8iiZDPdMgAhD6
         EQDtjG+rlyS00Czczv3q3efIHu0PODN2r0pdz7iqtFsrsVD3t8N0ArjHqAP1C6D6i2R7
         +yRhLULldk1tN5GHUVzPzZOPBnc9ez/8vIvcs+HLZqBO66cKi2hMUj8LIML6q1eNlzKQ
         8eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705589177; x=1706193977;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V/rb3e7RICwYcaa6sGQk5hX7onXeunnOrGGXPUjSP4s=;
        b=MZrI4kbRyn9fPKmOklZQBlcEGRKr+HIsciEfrD2tQgGM7QFe03I5ZntHs4i+biFAWe
         APwE6CH5EFSR8QCawJm805js1/wzbbElImSf3QapkR1VkvN++LANH5/0L7Q/5a9HMUUZ
         J3WqjasnvuZRND352oGuQJzX6Nql3kyu8UYLmn6kezFd1vQ8i5OAmmYF6dVJAmKk2zrZ
         TO6sOj4oPrsnRhHDk2eOPEfrokdDkb+k7IqpM0GxIcPZSDavqxcqYHey+DmKWJKnckV4
         HKpxPSF16aGRCwsdvGs+EBgvZXGyZe3IgZ4jPutblNHVGm82D+MM3iL3Hruyto6gf5W8
         F13g==
X-Gm-Message-State: AOJu0YzfDlxnjOAT4Mqp9fMwNYsFQXLN2nY9d0D1qrU5Xz8tpthxXREU
	4hPEPgbHgeNbRXFQoKsfnbFNcC7p/7J08vKFO1TyVTf+DvQYvcRV
X-Google-Smtp-Source: AGHT+IH+TgHvABrEncSHKKQdsk7gG56NyZWGS0rBtCCs3JQZ1KTPsJYVteYbiXaQa404+RhgAHTUBw==
X-Received: by 2002:a05:6214:d08:b0:681:8230:3136 with SMTP id 8-20020a0562140d0800b0068182303136mr831375qvh.78.1705589176859;
        Thu, 18 Jan 2024 06:46:16 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id kh13-20020a056214514d00b006816b56e1desm2425026qvb.129.2024.01.18.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:46:16 -0800 (PST)
Date: Thu, 18 Jan 2024 09:46:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <j-t.hinz@alumni.tu-berlin.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <65a939b85a763_1c8cde29423@willemb.c.googlers.com.notmuch>
In-Reply-To: <f4e27abc6741c175b4b1baf1331c30aaedeab290.camel@alumni.tu-berlin.de>
References: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
 <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
 <f4e27abc6741c175b4b1baf1331c30aaedeab290.camel@alumni.tu-berlin.de>
Subject: Re: [PATCH bpf-next] bpf: Allow setting SO_TIMESTAMPING* with
 bpf_setsockopt()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

J=C3=B6rn-Thorben Hinz wrote:
> On Tue, 2024-01-16 at 10:17 -0500, Willem de Bruijn wrote:
> > J=C3=B6rn-Thorben Hinz wrote:
> > > A BPF application, e.g., a TCP congestion control, might benefit
> > > from or
> > > even require precise (=3Dhardware) packet timestamps. These
> > > timestamps are
> > > already available through __sk_buff.hwtstamp and
> > > bpf_sock_ops.skb_hwtstamp, but could not be requested: BPF programs=

> > > were
> > > not allowed to set SO_TIMESTAMPING* on sockets.
> > > =

> > > Enable BPF programs to actively request the generation of
> > > timestamps
> > > from a stream socket. The also required ioctl(SIOCSHWTSTAMP) on the=

> > > network device must still be done separately, in user space.
> > > =

> > > This patch had previously been submitted in a two-part series
> > > (first
> > > link below). The second patch has been independently applied in
> > > commit
> > > 7f6ca95d16b9 ("net: Implement missing
> > > getsockopt(SO_TIMESTAMPING_NEW)")
> > > (second link below).
> > > =

> > > On the earlier submission, there was the open question whether to
> > > only
> > > allow, thus enforce, SO_TIMESTAMPING_NEW in this patch:
> > > =

> > > For a BPF program, this won't make a difference: A timestamp, when
> > > accessed through the fields mentioned above, is directly read from
> > > skb_shared_info.hwtstamps, independent of the places where NEW/OLD
> > > is
> > > relevant. See bpf_convert_ctx_access() besides others.
> > > =

> > > I am unsure, though, when it comes to the interconnection of user
> > > space
> > > and BPF "space", when both are interested in the timestamps. I
> > > think it
> > > would cause an unsolvable conflict when user space is bound to use
> > > SO_TIMESTAMPING_OLD with a BPF program only allowed to set
> > > SO_TIMESTAMPING_NEW *on the same socket*? Please correct me if I'm
> > > mistaken.
> > =

> > The difference between OLD and NEW only affects the system calls. It
> > is not reflected in how the data is stored in the skb, or how BPF can=

> > read the data. A process setting SO_TIMESTAMPING_OLD will still allow=

> > BPF to read data using SO_TIMESTAMPING_NEW.
> > =

> > But, he one place where I see a conflict is in setting sock_flag
> > SOCK_TSTAMP_NEW. That affects what getsockopt returns and which cmsg
> > is written:
> > =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (sock_flag(sk, SOCK_TSTAMP_NEW))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put=
_cmsg_scm_timestamping64(msg, tss);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put=
_cmsg_scm_timestamping(msg, tss);
> > =

> > So a process could issue setsockopt SO_TIMESTAMPING_OLD followed by
> > a BPF program that issues setsockopt SO_TIMESTAMPING_NEW and this
> > would flip SOCK_TSTAMP_NEW.
> > =

> > Just allowing BPF to set SO_TIMESTAMPING_OLD does not fix it, as it
> > just adds the inverse case.
> Thanks for elaborating on this. I see I only thought of half the
> possible conflicting situations.
> =

> > =

> > A related problem is how does the BPF program know which of the two
> > variants to set. The BPF program is usually compiled and loaded
> > independently of the running process.
> True, that is an additional challenge. And with respect to CO-RE, I
> think a really portable BPF program could (or at least should) not even=

> decide on NEW or OLD at compile time.
> =

> > =

> > Perhaps one option is to fail the setsockop if it would flip
> > sock_flag SOCK_TSTAMP_NEW. But only if called from BPF, as else it
> > changes existing ABI.
> > =

> > Then a BPF program can attempt to set SO_TIMESTAMPING NEW, be
> > prepared to handle a particular errno, and retry with
> > SO_TIMESTAMPING_OLD.
> Hmm, would be possible, yes. But sounds like a weird and unexpected
> special-case behavior to the occasional BPF user.

Agreed. So perhaps we're back to where we say: this is a new feature
for BPF, only support it on modern environments that use
SO_TIMESTAMPING_NEW?


