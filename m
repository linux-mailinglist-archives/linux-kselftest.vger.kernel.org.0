Return-Path: <linux-kselftest+bounces-38032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20043B14042
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EAE1652C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC52727F6;
	Mon, 28 Jul 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTbPN/7Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD021018A
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Jul 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720065; cv=none; b=dxUJ+c9yMNY2KxRNHi+DKGkSDQgcdbvijZtOFfC9/fbZX+/o1Vn7/kbkIDE+9zVsxMtUEtnbVWPZFbGHU72XQbkVlDz1shOeuWU58Pa67RYRboRg0/ZCfEsTFXmJvsvdmqNpi0fK+zwC7qrrpFxqw16XiwiWVNdVTwqrcpmFxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720065; c=relaxed/simple;
	bh=Ya45jQPXHk2oP2X0G+LpFes59f3rujaPubzq7KF+/kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEkz/AaKXIDWWjgl8fiVrtUZZFgvHwASqNuH9liBauTrqGvi2OgLxwVfNqrn38vOsQm81X5HUqSK0IspB1o70JYCmyP0vkHeLL7Is2655y2nUmeKNYXkwvn2yL1LWXa45wT76hxqQ0UNxV30ltq0oAKenHBqd+QGdrKKCjwtZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTbPN/7Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753720063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xArcZSjUcc0JM++Nvf69XtSLwcuglbrEMCVCa+W7/Rs=;
	b=aTbPN/7Y0kZ2rLuXN9FHn3BWzvQ4RJ3COuqVZK8E/IbMpNVC8yvnqO7yui3cV+m1hTroKn
	tTFM/FkNAed35NDjhuYGxU0UY5ZDUFYGjdgk9t2qF5kopbAkNHaxFrQwO937WXp4p5lH+f
	+Qt3ZDMKhAi3Bcowz4GVwzQSDR7Dfpg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Z4BSdzxyNuGtid6NW4xgoA-1; Mon, 28 Jul 2025 12:27:41 -0400
X-MC-Unique: Z4BSdzxyNuGtid6NW4xgoA-1
X-Mimecast-MFC-AGG-ID: Z4BSdzxyNuGtid6NW4xgoA_1753720061
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88118bfccf4so23361839f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jul 2025 09:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720061; x=1754324861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xArcZSjUcc0JM++Nvf69XtSLwcuglbrEMCVCa+W7/Rs=;
        b=ZLWwIRBOz8cS65ajQzUg9tdgOnbCuyih7eRW468t2FDjKiRmfmsHdpHp6X8EEO6kZJ
         j16a08cc9o/UeKgrH6iLXMNYRsqS9rFF8WIr6FXYT2PSrewI/xHToDYC/h5r1GpJCrab
         zFiGcKBXt/eR90HZ2tyZEeKA6Zd43x8SSs4r4XIBiQn2yiLqtBdMcd1H7Q7/OlpQGJVw
         IFqIYVVMexUp0CBHPDnIGeJncgdSv2h20wp/gfvTnIaYFQ4CEsGnlmMbYknPHZp7giDm
         UXNJnxema8yz8BQTUrmW6NSCXrDrZ50QGmdp4f+ZcCnYGLIpp6tW/DT1jt+F7Jt47vkW
         TmVg==
X-Forwarded-Encrypted: i=1; AJvYcCXgpCLs2ietxDW8aTIJvVIc/GhLZ+MyPjr6R4R4rUCO3p343p9+MtdtgD2fMcDeSD3Gyx+eLqEdc3JaAfBDpuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpimhp6+7vxWOT+2bE90MsPYuGi+YitjyVXD2GOEcBNBokqUe
	xNEMMY1Z888sIgoackSfczGhpvyef5JiKQbrVAsJrfnldcdlnfpz6fmKpicaRdGGcnMlmP+v6D7
	J41XQP5ONCYEKQbY4LKr/x+ONa7gy/yKLWxRiB89QDbbqHUvN/4SDVfCT9tLv2Bd1QGIXZw==
X-Gm-Gg: ASbGncu/55veeM8vFo96YbNiLmKMKuCkCrFnO6s+DUxB0dr3Rpmc5wzWVxXcZadKO3X
	1WsQtIl8FsZRYs6rvHxqmPaFRaqJcuP8Rdq9kWtOkhYvh4PkS8BHS6QgnkoFIS7ccsBJX520pDk
	lMI53ChcgN5Wa4AV7b6GUGvKCDXv0Jocv3ZGYgVvo2/191OO0HJojXkzoTTn3zhDEhS1G0UbJxk
	Wdhb1PIKJ/F75msvu13c1H5Nd47t02/Aio/N0YfgsIyWC7xq2dZYTtS+dBnQzFH5kp9uXFzLB42
	ZtT6yA+nbmAaOfsnzjq5l4pAQm6zpzVulCXznzHlHSE=
X-Received: by 2002:a05:6e02:1809:b0:3e2:c6a3:aa75 with SMTP id e9e14a558f8ab-3e3c5378324mr58629335ab.6.1753720060575;
        Mon, 28 Jul 2025 09:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpe+ugGAmXF2USuwRkLE9+KI7pOiQNBqc2vtbrZJCicQ1Wplt9KVvxUosu4y3uaaNZ0wXR2Q==
X-Received: by 2002:a05:6e02:1809:b0:3e2:c6a3:aa75 with SMTP id e9e14a558f8ab-3e3c5378324mr58628985ab.6.1753720060073;
        Mon, 28 Jul 2025 09:27:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c9223199sm1944955173.51.2025.07.28.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:27:39 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:27:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Matlack <dmatlack@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, Ard
 Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 dmaengine@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, James
 Houghton <jthoughton@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Joel
 Granados <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>, Kevin
 Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, Wei Yang
 <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <20250728102737.5b51e9da.alex.williamson@redhat.com>
In-Reply-To: <CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
	<CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Jul 2025 09:47:48 -0700
David Matlack <dmatlack@google.com> wrote:

> On Fri, Jun 20, 2025 at 4:21=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > This series introduces VFIO selftests, located in
> > tools/testing/selftests/vfio/. =20
>=20
> Hi Alex,
>=20
> I wanted to discuss how you would like to proceed with this series.
>=20
> The series is quite large, so one thing I was wondering is if you
> think it should be split up into separate series to make it easier to
> review and merge. Something like this:
>=20
>  - Patches 01-08 + 30 (VFIO selftests library, some basic tests, and run =
script)
>  - Patches 09-22 (driver framework)
>  - Patches 23-28 (iommufd support)
>  - Patches 31-33 (integration with KVM selftests)
>=20
> I also was curious about your thoughts on maintenance of VFIO
> selftests, since I don't think we discussed that in the RFC. I am
> happy to help maintain VFIO selftests in whatever way makes the most
> sense. For now I added tools/testing/selftests/vfio under the
> top-level VFIO section in MAINTAINERS (so you would be the maintainer)
> and then also added a separate section for VFIO selftests with myself
> as a Reviewer (see PATCH 01). Reviewer felt like a better choice than
> Maintainer for myself since I am new to VFIO upstream (I've primarily
> worked on KVM in the past).

Hi David,

There's a lot of potential here and I'd like to see it proceed.  I've
got various unit tests that we could incorporate over time and
obviously picking up Aaron's latency would be useful as well.

Something that we should continue to try to improve is the automation.
These tests are often targeting a specific feature, so matching a
device to a unit test becomes a barrier to automated runs.  I wonder if
we might be able to reach a point where the test runner can select
appropriate devices from a pool of devices specified via environment
variables.

An incremental approach like you're suggesting is usually the best
course.  Implement the framework and something basic, then build on it.
30+ patches is a bit much to chew on initially.

Your recommendation for MAINTAINERS sounds good to me.  I'm not too
familiar with the selftests, so I'll clearly be looking for your input
once we've established the initial code.  Thanks,

Alex


