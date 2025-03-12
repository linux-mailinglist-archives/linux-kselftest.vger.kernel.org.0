Return-Path: <linux-kselftest+bounces-28788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EFAA5D43B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 02:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C879189C686
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 01:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F26C14037F;
	Wed, 12 Mar 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b9QHqrJ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346A5684
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744399; cv=none; b=P3I/3rWl0HlPRS+6SsTp0zi5h7rjdUmhJJf4Jly9wL+15jR+ghQ24syKi/qaOU4ttqRU+jqx8+z05EXwTpkidSwoLBuCL4YyUqGMYVVEjEdMAW/1Xkb/H4EGeFULlOI4qUBIBIjkqD8PyzxWHncrTfqrdd6FHuq7wPPlqR2RaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744399; c=relaxed/simple;
	bh=VYGt35qTVOsA6c9AnrReg4RiVqScLvZKoC54q0LPeag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISidLOzW6rmQrLAfW1zT9z7prWxvd2ghnZjkMKNx/mk2ZAemVxuLiTewsU8SzVmZBv6p4FQbsuShcNK1N4AVvvDOzgRqsj/BOhkDkIschUQA7Gft7DcyLbMV92dZqsPyDZY7Jgc44viFhXoQT3hxouIRrt7sAohTHgMHDyMgAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b9QHqrJ1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2f391864so3188819f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741744395; x=1742349195; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYGt35qTVOsA6c9AnrReg4RiVqScLvZKoC54q0LPeag=;
        b=b9QHqrJ1rYoFNf+Pef18yOp6P3vh2yrj8jXuDgaEZzu5ZuQzgz2SnxjXDBrDX55wJT
         fW8qVh3meR36RrnANxUTC/o+eAbvOMar35AgZlLz5EfmBPmUuwabeD1xwzl5mltgh0LX
         Dqqrgm5qnfqTPo6gTW+wI682V7VMtsCR10HAJfSpdbm3CXKObU1Csj1SBnLixalNC0V7
         dUpXO2ToInrOIeMaP2KIIhKd1RD44Gj8cKRzNIJOKs4ogqbj6mO3Ga7a8ufjrCvjjrrS
         jm+emfxi2zV2qe0NHfvpXsKRdDK/tyIU4vH3hewF2QE4wAZQkisJ375b8gljg0ONtcVR
         tOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741744395; x=1742349195;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYGt35qTVOsA6c9AnrReg4RiVqScLvZKoC54q0LPeag=;
        b=TeO7iG/ekWk4FmGiJaMmxYHa0yl1iAdzpDkI7/J3MicFBBKy37VmU+uupwdYMOmgJR
         kjhB/SZmEpyiUrZN5RJhhgK9J2Bzv9Y8R4TX+jrlzwbE4q0thIzx3WkoQrNLi5ga3UNU
         empIMHhK+iLxLN72spo6e/uAFL5M4oygjfFtefGQfXfxO231zPTRUW2H9Vtq1wAdkefP
         7ZYzS6wbGkmjYWaQOrD8CyRV8nJWq5IqXMgPiLZAqT2nFBEIuv+yD76HceUa9gRafhI8
         Rw545/qbqEypJKnAn11/aP0G47IaWbb3gLagmzLWdpZqQJiMla2n+VGvlHr9Lelx/SW5
         MccA==
X-Forwarded-Encrypted: i=1; AJvYcCUsoZo5luI9epBdtD3N9usUL1k9pit69tn5g8VMDnqq/sqUe6uJZRwcQMFITUHOEkeTvGlbKa7pxHxPwnWRnPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVDVHkbr3jKAaEv20eoD4Jdy+tUNRNX12bYlrAII+72hKEBQA
	XUzJUN93B96EnBsGHK5v6MSTl4PU1SHFk4YQ1M4iLumOENMBK8Fx8uYjJLCovvw=
X-Gm-Gg: ASbGncuDJaR1y8rNcNKbrq8oWXYYk09PRcTGcKoczshT7JfPVGQ7E8B/OsNYJPYDXSL
	mxYYwkJEYGAUgjg+uvzXEM5edOtpwWbMv8ruhLFUUPd5+prnbVNqlHUHE3LF7R1uFhUOnUl8Ir8
	ILaeTmJxN4KadnpaWP3MSaVlxILy/zySXjFfgw7qoTNH1mWLY8U3d9iXuOaX69qKgBenGIMNMi+
	kCdfdEVCFHO8ngSW6ysCQlX5NsCPtr72t70T8zfyNWQnf7dVFw/oLHNaQ6dTYK+lFLnHjbSsGuL
	tdm1OV1SeWkC8ltv4rPmCZ2I8KNuDsrcnUdQNcs23v4HvBxokCtlraN99722vu1AHrpKmQh1T5j
	b8V9dICU=
X-Google-Smtp-Source: AGHT+IG88cW0bSsvG/lLs3Zu0XcM2ByGWX+m4X6L8KGTkFm3WjWL58mXweufMtUVmgd7CjozBN1Kaw==
X-Received: by 2002:a5d:6d8c:0:b0:391:275a:273f with SMTP id ffacd0b85a97d-39132d062ffmr12511792f8f.4.1741744395630;
        Tue, 11 Mar 2025 18:53:15 -0700 (PDT)
Received: from ?IPv6:2804:5078:802:e100:58f2:fc97:371f:2? ([2804:5078:802:e100:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc694sm104552195ad.257.2025.03.11.18.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:53:15 -0700 (PDT)
Message-ID: <fe554a6efe55d7a9fda58c3aebb56322f742b12d.camel@suse.com>
Subject: Re: [PATCH 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Filipe Xavier <felipeaggger@gmail.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>,  Jiri Kosina <jikos@kernel.org>, Miroslav Benes
 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
 <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, felipe_life@live.com
Date: Tue, 11 Mar 2025 22:53:10 -0300
In-Reply-To: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com>
References: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 18:51 -0300, Filipe Xavier wrote:
> This patchset add ftrace helpers functions and
> add a new test makes sure that ftrace can trace
> a function that was introduced by a livepatch.
>=20
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> ---
> Filipe Xavier (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selftests: livepatch: add new ftrace helpe=
rs functions
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selftests: livepatch: test if ftrace can t=
race a livepatched
> function
>=20
> =C2=A0tools/testing/selftests/livepatch/functions.sh=C2=A0=C2=A0 | 45
> ++++++++++++++++++++++++
> =C2=A0tools/testing/selftests/livepatch/test-ftrace.sh | 35
> ++++++++++++++++++
> =C2=A02 files changed, 80 insertions(+)
>=20

Thanks for sending this new version! One interesting thing is that you
created a new patchset, instead of iterating on the same one, and this
triggered a bug on b4[1]!

You also missed the changelog since v2, but AFAICS you addressed all
comments from me, Joe and Petr, per [2].

For the two patches:

Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

[1]: https://github.com/mricon/b4/issues/58
[2]:
https://lore.kernel.org/live-patching/b2637bad-9022-496a-9b83-0d348a6350b4@=
gmail.com/T/#m14bc5c118490c1b17e782a0f0173c1fb70d187c7

> ---
> base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
> change-id: 20250306-ftrace-sftest-livepatch-60d9dc472235
>=20
> Best regards,


