Return-Path: <linux-kselftest+bounces-47821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BC9CD569A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 10:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE1A3014DAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135E30BB9E;
	Mon, 22 Dec 2025 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/CE8az6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2730ACFB
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396917; cv=none; b=NPcTebBbAI3/U26o8TMQFwpxBDMKuHpqnrN8ZKbGx5QjLSRGTycczElyZDz/VJK37PaIJ3THmhOCZthBjDOY8KXZktvnq9xupbNevY8wDsN0mMBSY52UQpq7ovjqwUhfCI5n/GWIwAstE6m+kWRK39pUoNbEtQ4GBTp/SU8Yrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396917; c=relaxed/simple;
	bh=BFWeRYpk582Dj1H10KmnL6ohapHXluTPgBRd3PojY9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjAI/K5iFYqPczcFdU1Iw+Xi5uxD11B9U7uMPFx9wont3uuwBvqxovKnrcQ89F7l0B5yVo/8owSeGQKVlv5tNIU8doU3qrYf3GK4vSNOeFETaSxULiNtulZB1/T0bhrqUTlZgXcAn9sK9loicpkbyXvTmfENNGvyFkqp9dni8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/CE8az6; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso24137855e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766396914; x=1767001714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpp2j64eyQIDdIrB75XVaxQv4OqlhELwCC5ZDUyvq6Q=;
        b=F/CE8az61xc32bEpCmnEN1yiWwVC/pxbbuDzDyELf8esdG/d8JCdmeZP1mR1np4DxX
         Rct6ktFeFKBF6ePvxoLfGTaJgv1YbMWqDTjRuFRGUGXwfLRFFDuB91HfujfLRvUm/aKm
         R8q2zVdAwA/nJ+4l5EBt2hCP2TA1sV4c8vjEZs7l6yKb970ZAiM6P+cr5M9sJm9Cghmw
         FXQXJ9d4P0BWk+LF/uAlHLdZsV0uMMDhxrpjoV0yQSo41y6mdzHbzXXCBSRRB705s3mv
         OBIkXCkatYnxsNcbI+kbkFrGWppk6Ei5BC3K0BOhymxg2Nwbi6oIB0JmDatAEm175f9D
         WpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766396914; x=1767001714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cpp2j64eyQIDdIrB75XVaxQv4OqlhELwCC5ZDUyvq6Q=;
        b=G5dWvVWOJM8OaGz23PQPWZyNoLrKdCXAM9emduvOqfr/s1sBVLJcJWN+m/HSqVUIYq
         81n8mWhuAjtK3ZkTC/srz1L3LI49TsQTIDf/9SWRJG7OCJFcGIRWyhdBjYmSOqTFQGuX
         BvJOtwk+3JBR90AX9/y/i/Y9+yVGP1ciHECbVcTxZvCLj4NsA46UloN8CSNZ+n21dyKD
         REociTjuLJI8qywWBwHqFRG/QYVn2DO8kxdLPOtQtHf+99e65z4NKJsl16O0hZVltIlz
         UM6moyHtUcb+xTkYK1V6Cob6IvhFB/1/hIzCtCHswBOJ9WO53LTrHlqkHDEUltVOHnMp
         8cnw==
X-Forwarded-Encrypted: i=1; AJvYcCUYkprWC9Kmot5qGkz0mSsNapwQRCkuyQRP5o2ZuPRYtN+xHusFrNnDXmUiyruQxwYir7rQEveSLu0FjJ0PDEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFz8eDSuGgZLimnGqASuSa6vkmeyLCMD6CjSE8oJqdjH4jGVM
	kGPamNFvlgfmCvnMJAU5jVBvuYbvf3ZV0lIv+uWHYeZuLiP7kUPGNoX1
X-Gm-Gg: AY/fxX68ej+mTzCNu6iU6jKszhW4bjx9J8jswk5v/0phyyViYOKtj3bzCcq7NPZVLpJ
	xvgfQvQTsPUwreyV+Zl26xNh7+GWjZnhHAbwY946wNBtf/FtFzH9O0+sdds6I1/vo6bB+uh49dL
	bJQffizKiav8iKWwgYU4+idwYsJmXHOGfkigSSGCE4VnPiDfYk5iXAA51LRNTUuhVBF1wFtMkV8
	UU8d3oxPccsOUhAUmoZcm89GNYX7PhgA6ug0tIBWnPVgefldz3Gum6fYL6Zpftne+t5Hq5gZUTs
	sD5QIcxeShjsZ57CT7WoVJ1HCTadzS+bCgoY2L4WGoG52w1HgqIKUrsCC0d6d+OfGdHq7EDsjWd
	I91vGUCxZ41rnG1IAsHCw+VJZ4JDamvfZdm1Dhb4p52wB/V7NlbywjxjSfr/LmIVYn+TG7Hkyc2
	oxZ5KrOAnNcBgWeA/+JAK6/6+dDmgfWa8Sh7m+wnl+RrV95cqYAys=
X-Google-Smtp-Source: AGHT+IF6jYkceDSxr0q7W5Uf/me1u68y0/0ia7Af2JYTdBnbk2BDeEsYBndbKG1YGF/M4co0yuY0Mg==
X-Received: by 2002:a05:600c:4506:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47d1957711fmr98592555e9.18.1766396913629;
        Mon, 22 Dec 2025 01:48:33 -0800 (PST)
Received: from pumpkin (host-2-103-239-165.as13285.net. [2.103.239.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm231821355e9.4.2025.12.22.01.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 01:48:33 -0800 (PST)
Date: Mon, 22 Dec 2025 09:48:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Li Wang <liwang@redhat.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand
 <david@kernel.org>, Mark Brown <broonie@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as
 size_t
Message-ID: <20251222094828.2783d9e5@pumpkin>
In-Reply-To: <CAEemH2f40t+4SsjL3Y=8Gid-CBMtf3eL1egsPKT1J_7LDbdWPQ@mail.gmail.com>
References: <20251221122639.3168038-1-liwang@redhat.com>
	<20251221122639.3168038-2-liwang@redhat.com>
	<20251221221052.3b769fc2@pumpkin>
	<CAEemH2f40t+4SsjL3Y=8Gid-CBMtf3eL1egsPKT1J_7LDbdWPQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Dec 2025 09:45:41 +0800
Li Wang <liwang@redhat.com> wrote:

> On Mon, Dec 22, 2025 at 6:11=E2=80=AFAM David Laight <david.laight.linux@=
gmail.com>
> wrote:
>=20
> > On Sun, 21 Dec 2025 20:26:37 +0800
> > Li Wang <liwang@redhat.com> wrote:
> > =20
> > > write_to_hugetlbfs currently parses the -s size argument with atoi()
> > > into an int. This silently accepts malformed input, cannot report =20
> > overflow, =20
> > > and can truncate large sizes. =20
> >
> > And sscanf() will just ignore invalid trailing characters.
> > Probably much the same as atoi() apart from a leading '-'.
> >
> > Maybe you could use "%zu%c" and check the count is 1 - but I bet
> > some static checker won't like that.
> > =20
>=20
> Yes, that would be stronger, since it would reject trailing garbage.
> But for a selftest this is probably sufficient: switching to size_t and
> parsing with "%zu" already avoids the int truncation issue.

Have you checked at what does sscanf() does with an overlong digit string?
I'd guess that it just processes all the digits and then masks the result
to fix (like the kernel one does).

It reality scanf() is 'not the function you are lookign for'.

IIRC the 'SUS' (used to) say that this was absolutely fine for command
line parsing for 'standard utilities'.

It is best to use strtoul() and check the 'end' character is '\0'.

	David

>=20
> @Andrew Morton <akpm@linux-foundation.org>,
>=20
> Hi Andrew, I noticed you have addedthe patches to your mm-new branch,
> Let me know if you prefer the "%zu%c" enhancement in a new version.
>=20
>=20


