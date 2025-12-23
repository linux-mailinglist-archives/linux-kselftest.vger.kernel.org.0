Return-Path: <linux-kselftest+bounces-47925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D3CD8965
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 10:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39AAE301738F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7832572A;
	Tue, 23 Dec 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn3ub70d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mztu91aK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860182F6930
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482198; cv=none; b=Um+lz8Q+mJkpSa72FWZ6POD0uZePaCwEUVkGBay4648GGcl1sokInjmZI/07UuiOxiY/KeScTdZHiNJGrg4xVOeWRauevVl/JU9zqryvycaHK8PLRMYQcl+MKOCT1rndRsqI9cNpG/h4BVajfKCL4rBmvkGNMuutnrtgejxlj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482198; c=relaxed/simple;
	bh=5nhee+lgjw3wecXKBaUvZOSHuBGe6wuTe9ztSF7VyYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9I7J1UCt2T1YZA/xRXUqkEQzazMl0Zmt5gq2vbJx+hk4381PftgbAAniAp4kDg99ub4/nFzPRzcDpNvopFaeMvVpy8YxKRDc0PoqQrBGL8qjAi25p9eq41RgIdpAD445bYspjXYQdD5Vc5lw9KTLhbbm0nRO6PF1HPWoi+mvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dn3ub70d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mztu91aK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766482194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5+yO63YwLa4flqsofkNkaWk7XgJtylB2duw+RvJS3E=;
	b=Dn3ub70dcXtw4zodcLXnF0+IYXY+5JFaEuYLKg3CubYOJsZzhZL1+fZNYrIM1W0CvN58ka
	LSDdkOHZaiCeJyI9SEqv1m58XT99XrQuuUkvggmnv5C2TpZC1r1X3j/3fhAvFYr02QDu7K
	sXlJlSP0W3zxotUEDyk+vOzmu7wc0Bs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-6eGOH1zPO1maujv2L7r3hg-1; Tue, 23 Dec 2025 04:29:52 -0500
X-MC-Unique: 6eGOH1zPO1maujv2L7r3hg-1
X-Mimecast-MFC-AGG-ID: 6eGOH1zPO1maujv2L7r3hg_1766482192
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bc09a8454b9so11667418a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 01:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766482191; x=1767086991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+5+yO63YwLa4flqsofkNkaWk7XgJtylB2duw+RvJS3E=;
        b=mztu91aKAl+uCnWxcgHvrSzd/b2S/FT2u3+hbIw2LPnBUgcRy58/oMVYrmChbx9bHs
         6iCm6Kb7xXqcL9Sra4S2kwLUbXpFycF1vJtwY9ELeOqRbIWjbmOy9VmdQdXTaMeEEFaA
         9qMCzDCEdvzrowAJXVB2eGZuMejndxRad7QDEhbd5NrvcOMX93O/i5c6loyLCBYzvapS
         X8n1Ey2d3GwSdma7PBUmgpcsWrl29i5OoofGNibCCVdqXW2LNcvBKGeCqjt4ku+NA32J
         u9NYNKDgYR9nUuYmYxLx9dYEd2xi0sxMwTSb1cyj604bnV47QB0UaqcUFYgfYlOmTLPS
         LEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766482191; x=1767086991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5+yO63YwLa4flqsofkNkaWk7XgJtylB2duw+RvJS3E=;
        b=nKmwvY4qatQ9lfzhlr2Xc3dB1fqebZqCXFo+kGwljjojmgy1IyAaJvqqrKEsCgHCYE
         T8ckq2WxqcPEutQMVr39WaN+o7oaCNX+0f5rKVDMe80jp8+1D0FYL28B1jwJRBQltPDg
         1gOX38OUDqBBNQE7nMA7ZfDdPpNCJvBwwIY6w0J67gudV0D3b6I8lqp7Xm2KKDEUDU60
         NnA58MZrw1fZigwI+OUeo4xs4eBbMZrIriiCnhePPI0+lOk2ck9iMCJ+HQTYCuMnykB3
         zphv1A0mRdWaTV9OF7mIX946TJWvYCOV3PgrC5FwnPCtsj4fPgb5+/t5/gW0dK2Xl/Kf
         92CA==
X-Forwarded-Encrypted: i=1; AJvYcCW0omvXDYZkGVhxsAahNPHZVcUHm+OS1NifFa0h0oiyzZ3uB6l9KkW790Vhiw/3ebPKKsoOI2yzuGIkUo+novM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjy+WZ3T3hwQQh3i/VDpnS31L2wIxQvzWrH7LAARyI+9NGMJ+F
	2UnQo8+Ps4Rdy4/HrHhowt5k20zh+ZlH0m121lfdykmkedQj35fS0pH46+C0FvL/nURviIYqfNy
	TDm8q6lcYRJClZqSQEYNlboyiDVN+v5AqkoioUa6X6/9EFKNzauMU7ZMNQ5v8Bm4u8C3jOYksx/
	2YiFCWgdKq+juzsdszIUHRwyyg7aD5p32D8+xNDj4J9AU6
X-Gm-Gg: AY/fxX70w+qxZ2JS5sqJH7uvRPtWHu0mL+IxLiCVQfJjToM0EcKcTjrDkRRQjJLtrqx
	Cjn/T0XOb2oftZTsFhJFxmye0vDWmcaJpAA8bcOI+NAGnJTZFgFqdyuJrcBr6EocijwE5MFm8CG
	uikcIP7h2HjAOJZcYLeDjhXBKD5P1RTA1nZO+MFf29aTKGYlYoRA2kefYiE7r814s9c1I=
X-Received: by 2002:a05:7300:2aa6:b0:2a4:3592:cf6b with SMTP id 5a478bee46e88-2b05ec0281emr11037157eec.15.1766482191554;
        Tue, 23 Dec 2025 01:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhPgrR15PKVagmzN7a6PStvExivEAOucLTLUlaHSb2NA12G5e7NTScTQz7LY2+bHQ6pqAyAVZSFZr/lVtpm0s=
X-Received: by 2002:a05:7300:2aa6:b0:2a4:3592:cf6b with SMTP id
 5a478bee46e88-2b05ec0281emr11037139eec.15.1766482191161; Tue, 23 Dec 2025
 01:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221122639.3168038-1-liwang@redhat.com> <20251221122639.3168038-2-liwang@redhat.com>
 <20251221221052.3b769fc2@pumpkin> <CAEemH2f40t+4SsjL3Y=8Gid-CBMtf3eL1egsPKT1J_7LDbdWPQ@mail.gmail.com>
 <20251222094828.2783d9e5@pumpkin> <CAEemH2fsAmhAkGAQb9rtD2WLUc7QMb9Q5dusG3S8LsJbNKsO_Q@mail.gmail.com>
 <20251222180509.b12684e112195ac3f7ee9389@linux-foundation.org>
 <CAEemH2dZ3DxDPWuV1Uze213CqoFHec9kK+MeteigGANYTUzbqA@mail.gmail.com> <20251223084035.67ba1b76@pumpkin>
In-Reply-To: <20251223084035.67ba1b76@pumpkin>
From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Dec 2025 17:29:38 +0800
X-Gm-Features: AQt7F2rofrXsNRAbOaW8CCv-eBKvwDj-FJXSisJFaKR--ywyBYO5VAjZBdVePmU
Message-ID: <CAEemH2e3C_oor-CK3_35m-gAp6uU5+75up7sL0wfX1MZdh3+jQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as size_t
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Hildenbrand <david@kernel.org>, Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

David Laight <david.laight.linux@gmail.com> wrote:

> > > > --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > > > +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > > > @@ -86,10 +86,17 @@ int main(int argc, char **argv)
> > > >         while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
> > > >                 switch (c) {
> > > >                 case 's':
> > > > -                       if (sscanf(optarg, "%zu", &size) != 1) {
> > > > -                               perror("Invalid -s.");
> > > > +                       char *end = NULL;
>
> Initialiser not needed.
>
> > > > +                       unsigned long tmp = strtoul(optarg, &end, 10);
> > > > +                       if (errno || end == optarg || *end != '\0') {
>
> I doubt that use of errno is correct.
> Library functions that set errno on error don't set it to zero.
> The only test needed there is *end != '\'.
> (end == optarg will be picked up by size == 0 later - if that is actually
> needed to stop things breaking.)

Good point!

>
> > > > +                               perror("Invalid -s size");
> > > >                                 exit_usage();
> > > >                         }
> > > > +                       if (tmp == 0) {
>
> No point checking for zero before the assigning the 'unsigned long' to 'size_t'.
> So the result of strtoul() can just be just assigned to 'size'.
> (Ignoring the fact that size_t will be unsigned long.)
>
> > > > +                               perror("size not found");
> > > > +                               exit_usage();
> > > > +                       }
> > > > +                       size = (size_t)tmp;
> > > >                         break;
> > > >                 case 'p':
> > >
> > > Geeze guys, it's just a selftest.
> > >
> > > hp2:/usr/src/linux-6.19-rc1> grep -r scanf tools/testing/selftests | wc -l
> > > 177
> > >
> > > if your command line breaks the selftest, fix your command line?
> >
> > Yes, I am ok with sscanf() :-).
>
> What was wrong with atoi() ?

As the patch summary described, write_to_hugetlbfs previously parsed -s via
atoi() into an int, which can overflow and print negative sizes. This
problem was
found on our kernel-64k platform and

 #./charge_reserved_hugetlb.sh -cgroup-v2
 # -----------------------------------------
 ...
 # nr hugepages = 10
 # writing cgroup limit: 5368709120
 # writing reseravation limit: 5368709120
 ...
 # Writing to this path: /mnt/huge/test
 # Writing this size: -1610612736        <--------

> Or, at most, strtoul() with a check that *end == 0.

True, this will work as well, but as Andrew pointed, it is a tiny test issue
and also resolved by sscanf() so let's just go with it.
(He has added patchset to the mm-new branch and queued it for linux-next)

If the issue remains controversial, you could send a separate patch later.
Anyway, thank you for the review comments.

-- 
Regards,
Li Wang


