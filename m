Return-Path: <linux-kselftest+bounces-12471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A365E912EB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A211C21C06
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE48717B42D;
	Fri, 21 Jun 2024 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzxEiWCu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34EB16C6BE;
	Fri, 21 Jun 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002657; cv=none; b=FJn60z3q3iCROZFKW6SRrdHCYfYGI2iR1KXWZhnRmSki5CQKgn+t6GRRT7F8RTmJZGkvgv+vzojiEsKsu6ZAFykbVvy487CMg7rWYUZLc9FpeB2r+iIwi0OC/sn0vH8isyQpm0wTIJCkFquupuS2Tmsp67rBjEYY6J/3tw63LH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002657; c=relaxed/simple;
	bh=pfNwabvllShkAC6sf3O0P9W32GhTAgZ0lvvNmLtOjis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gsgh/QqKaMKwkPY5f6cfucHA/o9bnJH1DYa7t4tj6vRCuuUkVmaSFdaAr/8FkOuFXDZhZFNsYtx1giCZGYDMpw1nHcsMP2C7xZBNhM5SDJSpgopTyUW7PtI/+v6Zvwtrj9Nnf7ZebWx7GCy7dvpOAUqZ9xi1s48PMyhlRbuT3SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzxEiWCu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f6da06ba24so18149015ad.2;
        Fri, 21 Jun 2024 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719002655; x=1719607455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pfNwabvllShkAC6sf3O0P9W32GhTAgZ0lvvNmLtOjis=;
        b=GzxEiWCusknyF15xlQ+7RsTQVLpRJZ8JPZJodSAhvghCsoLV+hoKiKkcPTEB8zK2v2
         KQYX3+s2sltbafjc6L5kKh1Vc4+Nq7/kyVufdtCn5s/MED06yTyDEzmXJD09YOWozxFT
         RRZEatqQhw8szkdcNrcjLrh2iqp0H22j529j+aUXmBAQbzBmsvJcflY+Bgt/Mv2Uehao
         VkeBEucqsl5VFjeCEGTnXSKKVPmPVLyg/xgwdeWOw5nDo2AozYDuyw0VYc4zo/pZFO6E
         29ROIhFmRXdtuUNprryF2W4NzRkNhqjETq2BzVGEJYH1tXi7nR84Yxs3yEQ29CP15A/e
         yC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002655; x=1719607455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfNwabvllShkAC6sf3O0P9W32GhTAgZ0lvvNmLtOjis=;
        b=mke9JVpD0ZgP8+mcvudiIHF5ssGvkvvsReE0qAxN5KFiaYPh0FFzntGy9BAC42VmcA
         x98EixilcNMqQZp2kZM0WP0TO7QKaP+cObqJ2RVuPPTe+nF0x/5CORlMKsYnfp5ykboh
         dzq0otHDFc6tj1bFBUOZqG6zM2PaPbcMAvJIDSPxGsDThLYuZx7apEY0LnYh3rvPYqGt
         Zw93sN3pe+XaN9LpDwGNPm57VGgGYsCBdv2cpmIc6/RAh6mBlV29YqWstCza+IRmHyXV
         AxaLTz7DL1ghtvGNV6vg/YyM6lJe0/HwkmKWGJ4WcNgDq60+Bzm/UYaqZvuvnQh8+ub+
         AG5A==
X-Forwarded-Encrypted: i=1; AJvYcCUBJDrOTbotSsYjdHcnnzp2wv1oeuAuH/v1LNyjZ3ncXQPyM9XlWjgfhGegNZULDf5kvJXwOy3BJxJ8+fNecKzG3xNgQU0Hva3NKSg++X7xeO+erM45mw8lH/2fF0IIcAPsgAHd
X-Gm-Message-State: AOJu0Yz5QCPSQFmhm78spqywpSOzSAd9E75pKSyjZTxYbVQlEu8/eRDB
	STrGjnu57a5fzyGk5kXCULFGdePFYhIBr27f0mmZmF43vcZc9Lpk6PmgBvmt
X-Google-Smtp-Source: AGHT+IHTRISwoxtVCUPNST5nBWt+ah1CsxfgA72Y2qnF9MelSnFIsDwgN3CIkwonWfNMofYLnmuvRQ==
X-Received: by 2002:a17:903:188:b0:1f9:b35f:65f4 with SMTP id d9443c01a7336-1f9b35f6777mr91719095ad.13.1719002654792;
        Fri, 21 Jun 2024 13:44:14 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7d245asm18330045ad.232.2024.06.21.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:44:14 -0700 (PDT)
Message-ID: <907a4f6f773155a2d12c9ae38955a5e5919dd8de.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/6] selftests/bpf: Use start_server in
 sockmap_ktls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 21 Jun 2024 13:44:09 -0700
In-Reply-To: <37b9e2f3c61b4bb73326f6c4e63d562433b59255.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
	 <37b9e2f3c61b4bb73326f6c4e63d562433b59255.1718965270.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 18:35 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> Include network_helpers.h in prog_tests/sockmap_ktls.c, use public networ=
k
> helper start_server() instead of the local defined function tcp_server().
> This can avoid duplicate code.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Technically, this is not a one-for-one replacement, as start_server()
also does bind() and it's listen backlog is 1, not SOMAXCONN.
Looking at the original commit, the difference does not seem to matter.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

