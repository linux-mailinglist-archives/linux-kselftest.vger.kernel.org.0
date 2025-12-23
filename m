Return-Path: <linux-kselftest+bounces-47905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A58CD7E4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E133009ABC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCEA28E571;
	Tue, 23 Dec 2025 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCiW6rT1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XM28tmVy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB528E579
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457703; cv=none; b=ieo0LxSPxDJVbHpvNWI2jqWP9CN5vfbYlNCnd3K14Vn5qUipZaP+Z3C/bafHCJFQvax7GnngR/sW06Fx3HCggm4DqlopyhKAyXPd3DJ4XkZjTqcgS5MHxTrhEzA6BmJvSq/Iq859tI0luhMMdufO84MegDp3agl8879YYl4U/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457703; c=relaxed/simple;
	bh=Gmya7MOyeIzE5/3xV8vvshsHCkPHOLGZJa602Z9foTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIFc9+8QbSKGHqL31JtVrA+WAv5QodwNopWJCGBTsXEz7iQAqFiVsvnqXQyh3Bdy6iUAHgPNvpkI+9kXwQrxxWMvEDmgZLwSgjQX+Wu/iznGRW/cmqs5tWHsbeOKLrXlPL/q5yPV7j1teWyJqfyut+78RHGpzim8AH1HDeUVKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCiW6rT1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XM28tmVy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766457697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X76OLfq9JWE8CxaMPmo7L22pFIXt692o1JOaTWhrH84=;
	b=NCiW6rT1FKmyHfrosGDoIQA9lneQPOwGTzUrIUuj7krZsP5ndyFvM9CzQL1AvRfAuNpGBV
	6SirpR3rXUELZjE53tvFVrZ4Shyrtpom53ZztHE9XfeTnDgAH4wgKB83FAtFVumBbxDwfB
	rsWJbnzpk6otdYT6wats6Zm9ttDsj6I=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-pJM0o8wEO9OS1MEKEtZvkA-1; Mon, 22 Dec 2025 21:41:35 -0500
X-MC-Unique: pJM0o8wEO9OS1MEKEtZvkA-1
X-Mimecast-MFC-AGG-ID: pJM0o8wEO9OS1MEKEtZvkA_1766457695
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bce224720d8so8551337a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 18:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766457694; x=1767062494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X76OLfq9JWE8CxaMPmo7L22pFIXt692o1JOaTWhrH84=;
        b=XM28tmVyZBwAYjHbG4XjpWuSAU3kYNkuI8emH3IKWS3OQ0FZAXsUzw5wJndH+mFObZ
         oGEOSAK/dXKjETl3ZMxUAA3LWYDvD767DOuF4CyhiX/AbWTFwFQvAbqAp91R8vL+7Qvn
         yRLCAI1GZDJDLXmL12PzpfUq+hVRVkfmdXb6aplKHR96TdDR4E3pN+RrmPln/2Laetcm
         d86JGCAyRgMCOM2ZtVhFLP99czr9BXlBWsPS1kQhSxjzP10JTpHZZXV4B/7rJ31h2lPF
         C1ZEiXHjzGLYxxsnTqwJ78J0GBbIqyxJr4Ra9MjIjan3hnYDFo+3fexdmjpaCBFC4P3w
         2AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766457694; x=1767062494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X76OLfq9JWE8CxaMPmo7L22pFIXt692o1JOaTWhrH84=;
        b=P9YzTepquSWj5B2T9bhb9ZOWDslGvvclCKAGjTPxP3fxFzw3xTRr3IVFedWKJmUUoz
         CxB78a8bVfj9kavcmNTCQzP8wuVw9Eq2oe1VgV1lkUUgS0z59J/YCpAn5PxfTtxt+Z3W
         Ih2MFDXmubxTswHH79BBq76wFCgEKXMQJad9qe0cIVY7YORsJ2ctSvjKDo9zLAl5aSMc
         YChwA865d45vriwFF1+Zqvq72r9qt55VCNWp+hCpH2BGReNgGnl68CHsBagGtIl7neah
         jy+D6oAHkIOve809O5bOQCVqo+VfGpgbuZwjdd1ZtS/fRZ7zxybZT+kanGoMjk9rO0kz
         B2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW88FT39DsZi2o6dTwJyGfaOfUrsTk9zYEUjd3MZMNnCdvHPwbJ8yeMUNUUAauLh/u59gZM7qrS2g8vvkGzIyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMugQGI/NwPDA+g8NWwM02HhDSKlVnC20wzMhUbYkRg9gUpkA
	sguxY0I2BVgiv/eQFE1Ohc0C/sUN8iEWqA7eaPsSGFSsfdUTcJUVyBuHeY5vx/K572h3Gdovsid
	1J3HzCuurlw+DpcHiOUtMJTwBzVqFKVHLY34T1qtKMz5scGT/T5QzjYaFl7iVv6TT9J3BoL7ABW
	YFxPZpgESm9qo2JGtELM8deO6+uctrCiNBYantL13Oo5Kx
X-Gm-Gg: AY/fxX4y7HSN6Dcvj0UHZNpo1TB0SKOEeKpSUCaKYSZSIc8v9Nk6+oQlyyqQ0MSmSV1
	/IrTKO+u/pEzSOxvxhUKgNru/cpW3zOvUE+tXKYfaAabECFiNienN7bYe7u82fZ27owbihioVQb
	zrP3cbkokfyZDMqBZ4hqOKiVf99sjwl+JQOso8TQ+8bPShqW/vNSDbn+ljG2CWhwBxYHE=
X-Received: by 2002:a05:7300:de4b:b0:2a4:3593:6453 with SMTP id 5a478bee46e88-2b05ebd8d92mr9946618eec.3.1766457694562;
        Mon, 22 Dec 2025 18:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpUovhZE5pBphm6qlEdgCz7WwEpmZEiTUnA6F9yN+mMZoFbFB7iUAcmRN4ioegFjm3mJuEAs51apuu9znPHw0=
X-Received: by 2002:a05:7300:de4b:b0:2a4:3593:6453 with SMTP id
 5a478bee46e88-2b05ebd8d92mr9946600eec.3.1766457694139; Mon, 22 Dec 2025
 18:41:34 -0800 (PST)
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
In-Reply-To: <20251222180509.b12684e112195ac3f7ee9389@linux-foundation.org>
From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Dec 2025 10:41:22 +0800
X-Gm-Features: AQt7F2qOIZm0BvL9DLtEgZtZpeJWcVubMomV_2ll-92wfg8FBEaptjEpncVydpM
Message-ID: <CAEemH2dZ3DxDPWuV1Uze213CqoFHec9kK+MeteigGANYTUzbqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as size_t
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Hildenbrand <david@kernel.org>, Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Andrew Morton <akpm@linux-foundation.org> wrote:

> > > It is best to use strtoul() and check the 'end' character is '\0'.
> >
> > Hmm, that sounds like we need to go back to the patch V1 [1] method.
> > But I am not sure, @Andrew Morton, do you think so?
> >
> > --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> > @@ -86,10 +86,17 @@ int main(int argc, char **argv)
> >         while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
> >                 switch (c) {
> >                 case 's':
> > -                       if (sscanf(optarg, "%zu", &size) != 1) {
> > -                               perror("Invalid -s.");
> > +                       char *end = NULL;
> > +                       unsigned long tmp = strtoul(optarg, &end, 10);
> > +                       if (errno || end == optarg || *end != '\0') {
> > +                               perror("Invalid -s size");
> >                                 exit_usage();
> >                         }
> > +                       if (tmp == 0) {
> > +                               perror("size not found");
> > +                               exit_usage();
> > +                       }
> > +                       size = (size_t)tmp;
> >                         break;
> >                 case 'p':
>
> Geeze guys, it's just a selftest.
>
> hp2:/usr/src/linux-6.19-rc1> grep -r scanf tools/testing/selftests | wc -l
> 177
>
> if your command line breaks the selftest, fix your command line?

Yes, I am ok with sscanf() :-).

In fact, write_to hugetlbfs currently only accepts arguments from
charge_reserved_hugetlb.sh, and the way the '-s' is used is not
very diverse.

--
Regards,
Li Wang


