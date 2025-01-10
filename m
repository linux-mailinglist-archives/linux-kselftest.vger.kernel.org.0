Return-Path: <linux-kselftest+bounces-24209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51EEA08F7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 12:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026811611EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC3420B215;
	Fri, 10 Jan 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/BoXch+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C077204C11;
	Fri, 10 Jan 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508761; cv=none; b=Tg2bpyy1YZAViULVVxVQct5lND31JpnaYsnXxKSRsepqj+Hn8VyTPTZhjit0t7DBSlQpoiWaVOp6n6DKpF4l1goOcu653k6DVc94IERUiv1obfkb4Qf6mGC9ZnDvCVIII+E+f5h19FX3sND1rL5csa3FHFQ5RT0MPSh5LhtIpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508761; c=relaxed/simple;
	bh=yLRKiodCpUEkNU747JZ4PBw6mzhLuN0TGC+xkk8hayA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CuUDNak/uz2zmvJss1bcOiVUe6XN9+NguzugrXpRns4nOvyhoGkUFkBiEFEeltSZ121VutoXR8NR0l0XJ/mObt3pFUaj324Oi57bLfaGu5kiHPI4rZyl5I/o3a9ulTwNSZ9cNWQ8d1DQP3kcEfl/fv2PsVkASWOtZfBs9Fv9PuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/BoXch+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a3f1e667so11882451cf.0;
        Fri, 10 Jan 2025 03:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736508758; x=1737113558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj5hzhLDurnV0Uikx72ybZP+UMepormLzXbaIUCT51w=;
        b=G/BoXch+vVFX8MZnyP7GJkHDIalM6oxvyavc530/8ycG9cp/9w0g69yOFkhR0T1loe
         u5H/4XYUxhISbrn6syhXx/jRCqut162mN3JLjBCQ0tr/nV12M5uoJhFzZ7QfnOFo8c3a
         E4w5jINEYKrYzGKVgIQQYp0fO24aocSoi/WIv2YXcTuE/N4Toblq8XsRL+gVIWEfeqkl
         B0UJaUpuXOBE43vcol6Drd1NvXGC4iNpVZnYSja/r+dsWpPI7pUSy8kkxOYmQ6q/TDfM
         LXmejD434RCbvQFXSYgE7egD72ngSfZ0YXV7He1mDboZ+/KRbK5+krEMvpluw98yjaBu
         pZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736508758; x=1737113558;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bj5hzhLDurnV0Uikx72ybZP+UMepormLzXbaIUCT51w=;
        b=rxs7INnfWOXebl7A8cJ2lVR93nPmRPK6wlZKEEYs9J0QsXh6mHyv/lWZS36ZwD1Gr3
         NKbMkV+RCCTQcOClrCA4vR2hhsqhdJD/eqNfMd1LKegSZ9pm5HrriXzr7+lVxni/FqQr
         HbgsGx8GIMuH42aOF2q4U148M5J6JCh/a1MFUpXK/yah5hhUvMT2ARXwjBasS0v9Qm/H
         qbwodPEGC+JXfiVtD/i6WKCNe0jJ3/ymV+EarSdDuix4nWkeJzGwVnbiPQGV7VxlAIyc
         kt91QfuRPmoJJpDa4IdgumCbDEuIhmRze7HXS4bMFC/Jb4dtrP41m60dQcQT9beI92eJ
         2JjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Sin9hcZIK9GoBwPmfOCP7uDDc5BIW7/ObfIrEG2fXADxjH2BKrDkuh/2QFj/hozbjaSeQZJz3p4BicJI@vger.kernel.org, AJvYcCUFwprI74G/voE34S12ym6M+LWjKgNYRQqtJfBCuyyHDfbvwcZy68wlRiJbUj67p9pWm9U=@vger.kernel.org, AJvYcCV4XiWoGCBnEt/Xa3DcrUJp2GE7CDSrFyL6WEe1dwiQHTcy6TKMuQu8qEoIb8jLgAs31nv62YhezBtaICnHM+xN@vger.kernel.org, AJvYcCWn9X1/7Le1qvgFxwdaM4ov3GgdwQbNvgx6K1aAf3Tk12fb5FwUzeaHxSLtLMVJLAlFIMssyXyA@vger.kernel.org, AJvYcCX4jcLigC2qgJaNhcYMAoisKLAkuoRMfv2fPoMMojkajR4bQIEyIXzJkmq37Y62noC01MiKBmY4/Hps@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5Xey5A11wS/kABJIe//HDJvaGkEaHmHZim9wG1ywUixZpWQ/
	KJRZmbMkbIy1pZW+utZ4eRVXIwwvbyNxpcSfcd05mvb2PkLNkwWs
X-Gm-Gg: ASbGncstO/rogbWV20Lq+wogBlF5TrQvmly3YoP6ewTxBOXDMJsh9IQie/e/5QepWK/
	zRoeYDVEpdOLdK94qdqsAYvU4PTdBTh7AHu4x+wBLDbSvLJXAXUUYZpUIqpTLmRGxoe+i1tbyJ6
	qryD6KpxApVFU4lixVqSJNqDR+ZCvKxe4j15hQk++3XzRpi77BKwkqDGewJVS3R/V6Xd1/0DrIE
	De4AvN4IxevzPeLqZm8ygrv538miaFrwtMQrsvqZjte59wCpPbdpQR0HGZFx5epjNPPOcFyhDpy
	2+mEeIeevjK0Pb5LR1rwmJFpDwri
X-Google-Smtp-Source: AGHT+IEAeRPcXEPZaY0ZiqE+FHD3WXuaK99GAFn6AMFjwlATA6fP06zaeLna0c3A/VPZLWprZOxVFQ==
X-Received: by 2002:a05:622a:1196:b0:468:fb3c:5e75 with SMTP id d75a77b69052e-46c710e13c5mr151993961cf.38.1736508758327;
        Fri, 10 Jan 2025 03:32:38 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873cd1b0sm8463741cf.49.2025.01.10.03.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:32:37 -0800 (PST)
Date: Fri, 10 Jan 2025 06:32:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com
Message-ID: <678105555a23f_3fe20a29440@willemb.c.googlers.com.notmuch>
In-Reply-To: <3a5001b5-9a07-4dfd-8cec-1e5f7180b88a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
 <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
 <20250110033306-mutt-send-email-mst@kernel.org>
 <3a5001b5-9a07-4dfd-8cec-1e5f7180b88a@daynix.com>
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> On 2025/01/10 17:33, Michael S. Tsirkin wrote:
> > On Fri, Jan 10, 2025 at 01:38:06PM +0900, Akihiko Odaki wrote:
> >> On 2025/01/09 21:46, Willem de Bruijn wrote:
> >>> Akihiko Odaki wrote:
> >>>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> >>>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> >>>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
> >>>>>> which leaves the garbage in the buffer as is. This is especially
> >>>>>> problematic when tun starts to allow enabling the hash reporting
> >>>>>> feature; even if the feature is enabled, the packet may lack a hash
> >>>>>> value and may contain a hole in the virtio header because the packet
> >>>>>> arrived before the feature gets enabled or does not contain the
> >>>>>> header fields to be hashed. If the hole is not filled with zero, it is
> >>>>>> impossible to tell if the packet lacks a hash value.
> >>>
> >>> Zero is a valid hash value, so cannot be used as an indication that
> >>> hashing is inactive.
> >>
> >> Zeroing will initialize the hash_report field to
> >> VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.
> >>
> >>>
> >>>>>> In theory, a user of tun can fill the buffer with zero before calling
> >>>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
> >>>>>> awkward anyway so fill the buffer in tun.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>
> >>>>> But if the user did it, you have just overwritten his value,
> >>>>> did you not?
> >>>>
> >>>> Yes. but that means the user expects some part of buffer is not filled
> >>>> after read() or recvmsg(). I'm a bit worried that not filling the buffer
> >>>> may break assumptions others (especially the filesystem and socket
> >>>> infrastructures in the kernel) may have.
> >>>
> >>> If this is user memory that is ignored by the kernel, just reflected
> >>> back, then there is no need in general to zero it. There are many such
> >>> instances, also in msg_control.
> >>
> >> More specifically, is there any instance of recvmsg() implementation which
> >> returns N and does not fill the complete N bytes of msg_iter?
> > 
> > The one in tun. It was a silly idea but it has been here for years now.
> 
> Except tun. If there is such an example of recvmsg() implementation and 
> it is not accidental and people have agreed to keep it functioning, we 
> can confidently say this construct is safe without fearing pushback from 
> people maintaining filesystem/networking infrastructure. Ultimately I 
> want those people decide if this can be supported for the future or not.

It seems preferable to write a value.

Userspace should have not assumption that whatever it writes there
will be reflected unmodified. That said, that is the tiny risk of
changing this in established code.

If it worked without issue so far, without hashing, then probably the
change should only go to net-next.

As said, there are examples in msg_control. I don't immediately have
an example where this is the case in msg_data today. A search for
iov_iter_advance might show something.

