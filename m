Return-Path: <linux-kselftest+bounces-47797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1DCD3E63
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 11:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC4133007FED
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2E82868A7;
	Sun, 21 Dec 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsEngCbm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iV+G0zxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471F27FB2E
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766311719; cv=none; b=ih7eQCFgGyrZBjqUlxNl8zCinp2LxjzVy1qTYBaNJcO8oieD662O26RW0napufatt6bQapd8b2XKiZFgB1aYcdHHW1EoCtX7IEsJi1Auy14fNs/rB6QHnjz4OfGezvBQ4Dr8hOWqNzoZcLAwhSOvSBcJnZCDojbtmAmQsFfm9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766311719; c=relaxed/simple;
	bh=zyY3+1rEnoDijqyHQ0OIOOcY5iJepV/rzJpTHeiHlkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGep5gF5gEAV/2z3sgPfH38487WOhH1qnGDumHT2rQku9w+LXEmp952QIoCS1ZUCmhq3Tj5gaCV/qdFet9KQTcq4IJGdubkx0s5mdv3+jWK/qASzh97KL1SQ0qFhFw9MzY+Mfzn5QNHUbAB0dNxUJ74QUFbOMs6iYHqX2axeNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsEngCbm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iV+G0zxB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766311716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyY3+1rEnoDijqyHQ0OIOOcY5iJepV/rzJpTHeiHlkY=;
	b=OsEngCbmVLiQ/Ykb4MLPAJ7JyMnMjDniXqIfckeZo5SSZpHy31B4lo3/51nBCfXIy2Gwzz
	rPkC6hfs7p5+6P1VSrRQsmMsV229EbfiVH4PsqGnbmlKdBm1owYfuozKpf09x9W5j0vgo5
	ZoDnxlBNP46uaOvGF5kCAc3osGjI7l0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Xx6TDqvjOYOm2o4WClI_zA-1; Sun, 21 Dec 2025 05:08:34 -0500
X-MC-Unique: Xx6TDqvjOYOm2o4WClI_zA-1
X-Mimecast-MFC-AGG-ID: Xx6TDqvjOYOm2o4WClI_zA_1766311714
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34abd303b4aso8438129a91.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766311714; x=1766916514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyY3+1rEnoDijqyHQ0OIOOcY5iJepV/rzJpTHeiHlkY=;
        b=iV+G0zxBtqDQTg+HwBP7zDxafZw0zdjhC2kRazyskESQ2nPVa2BPllN0bI+bdXu8y4
         WVtpPwgpUsgENOFPm5g5d6grWSF+VQSV2ubXLJFqPi6+aPO0YQlZ/FoOncvlKhLRWeso
         fC9zibfZ2Eqnom0rZZfJnkGmFy8bbnT5Fu0Er9SAS9lUZceaYh2uCDne3FJqaNPVH0UW
         Ln6B7PMTueq7zdoX/8EwDcebHXX1x7FbJA3wL4Ab2chasqdTzbKFp8ORqdPae36QqB5E
         S0JmZ70Vuuec2dqFdf5MdQ6S2KRW6jK5lkSyYA5HMvee4A5IlDPI1nqNJ5C1g+b25R4w
         SWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766311714; x=1766916514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyY3+1rEnoDijqyHQ0OIOOcY5iJepV/rzJpTHeiHlkY=;
        b=F7InqmfBZHRh0EPgj0n2FbaIqFXX61JMLsEyfojlrDzXdBIqQ+/eJ+JtWE8kzOSTl4
         PxwBPva1oESFFU/WOWVNn6+5il/G6Or7Pe1i4sXUhkbi2+QOjPrHzJ0I1NiXqoUmNLzf
         rgT9/buviCu3BylFEhsCAG83rjltk1hZA1OqpA1O2HjKvQOCM5Tp2Zm9lcAxRvJ7D7sw
         GTLCl9ICwJVyMzGf3lGxANECBMNIQ848/Van8NyVz/gtlVt9c4+CK2Icz0RswfueYeAn
         YTfFenYK4stBnsT4Y5SgI/EZLxVBsRfs+r+rVdkmIedmj4dbRSg7i4JXqyNyeCb/L5qx
         ORuA==
X-Forwarded-Encrypted: i=1; AJvYcCU/r9ouZNA08MK4hyS7vtENCAxp2qI/gOvA/teLJA5Vp6NZY3SbQUylBwecmMjyg4eNWSwgWy4NcpC3uJL3Wnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4ZCPajLhEROBdcvMH6YnmotXSkoSRqOW61yYS4yrDBUBcQm1
	FtfzqdX9YkgIR1J+96154t0hxsQCfJ4Wf2Q+ydbUyzCuXXUlFhKEf0oN7hsyVMno+cNT9z6B+zF
	QHuE+69mA5F/pUAcoUA0BViqiyPObvurFOl6s/MgFAbd8L55yKAKM8uvnHHaPgSKk8Yo7VxPpJS
	lRHN8dirGbksW/49i7p4eK1Ggp9nGgmb2RKLvP30jDbnPk
X-Gm-Gg: AY/fxX4dkNSdmCwgJEqYuQFQR/I8+uspkgcJ263Velcpi7JHiV/N3PKBfhUGxiUM1+R
	ZyQAWzYR2Ccji116hnGEuG7S3vaWCcmgRRXxfAEN7Ls8CCiHO9VbYPYei3vpywO4joKBAD//8hl
	jSIDo6zZrXqJ1niLOv8sEmI8sUh3UE14boP6HDxdYI/MDu3IZvl6gNAeeX1ajWcGOB4mE=
X-Received: by 2002:a05:7022:1a83:b0:11d:c049:2fa3 with SMTP id a92af1059eb24-121722e30eemr8954401c88.30.1766311713848;
        Sun, 21 Dec 2025 02:08:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDeyawahXkjprRnJdrVHnVTo5yBrVf5BU33fXel2INlNhB6BTii9wBPiPmDnDfmwEE66/c/GVZ25ciE0p4NGY=
X-Received: by 2002:a05:7022:1a83:b0:11d:c049:2fa3 with SMTP id
 a92af1059eb24-121722e30eemr8954391c88.30.1766311713413; Sun, 21 Dec 2025
 02:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221085810.3163919-1-liwang@redhat.com> <20251221085810.3163919-3-liwang@redhat.com>
 <74414ade-63fb-47ff-adda-903949468b88@kernel.org> <CAEemH2eH0a6vHhv80hDcTBxTUYHALrOKjtvWnajCwPk_zLpJ3Q@mail.gmail.com>
 <de5fa614-65c2-43d4-8c3c-549eeeaa5683@kernel.org>
In-Reply-To: <de5fa614-65c2-43d4-8c3c-549eeeaa5683@kernel.org>
From: Li Wang <liwang@redhat.com>
Date: Sun, 21 Dec 2025 18:08:21 +0800
X-Gm-Features: AQt7F2qbhpBZBRv4h5MO3WqbtQStWyLyVZv87R3KKsfAGjrEici9YtouzLddrGM
Message-ID: <CAEemH2cbnTwPFBYqnMB4nysUQ06FtCPBrVj1GYYGCyhseXPDpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftests/mm/charge_reserved_hugetlb.sh: add waits
 with timeout helper
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 5:52=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 12/21/25 10:35, Li Wang wrote:
> > David Hildenbrand (Red Hat) <david@kernel.org> wrote:
> >
> >> On 12/21/25 09:58, Li Wang wrote:
> >>> The hugetlb cgroup usage wait loops in charge_reserved_hugetlb.sh wer=
e
> >>> unbounded and could hang forever if the expected cgroup file value ne=
ver
> >>> appears (e.g. due to bugs, timing issues, or unexpected behavior).
> >>
> >> Did you actually hit that in practice? Just wondering.
> >
> > Yes.
> >
> > On an aarch64 64k setup with 512MB hugepages, the test failed earlier
> > (hugetlbfs got mounted with an effective size of 0 due to size=3D256M),=
 so
> > write_to_hugetlbfs couldn=E2=80=99t allocate the expected pages. After =
that, the
> > script=E2=80=99s wait loops never observed the target value, so they sp=
un forever.
>
> Okay, so essentially what you fix in patch #3, correct?
>
> It might make sense to reorder #2 and #3, and likely current #3 should
> get a Fixes: tag.

+1

> Then you can just briefly describe here that this was previously hit due
> to other tests issues. Although I wonder how much value this patch here
> as after #3 is in. But it looks like a cleanup and the timeout of 60s
> sounds reasonable.

The reason is that I improved the infinite loop before debugging the #3 iss=
ue.
But your suggestion makes sense, and I will reorder patch #2 and #3.

--=20
Regards,
Li Wang


