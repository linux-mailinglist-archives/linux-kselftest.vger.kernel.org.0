Return-Path: <linux-kselftest+bounces-36719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BAAFBA0F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 19:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545E84A0D60
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BDD23534D;
	Mon,  7 Jul 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCg9wNQY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B7188006
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910228; cv=none; b=FJ1SXWgvjZW6hvo8NtqCqGRN/FPh1yBBqS31wlXjtVDmx8lAS/lEDnL2NqzAlQRD1hLR/dQdzm00xaQl6c6jF0ZJ2bsQPqDDCYsG12rQxN+Cna7GNaBNOZOWB9r7gaAnjXl8b7N5NL7BDDzf80Jx7sNroLk6Ey1USv/01D7aJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910228; c=relaxed/simple;
	bh=6WL7P90l1zk4qe9y23uE7CFZJnUvHQ8dtMU17K5oHZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIi2U+7H0YlRqezJizAMzlPX92izWnqfT3cBkyTClq39XxAE/IQCsY+hRKyUbUmY6PwPc9IcCrhdWJ6e9ADGu8AtEYOfLXiUSyCutF16kt2YBn9Wxg8DZZd8X/zYqYSG1I7FqMK2TPAXrG/L75WA25REfbTLcOuK1VU5TXMf1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCg9wNQY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so41543721fa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jul 2025 10:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751910225; x=1752515025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNTmsp6IOfSThnweAThs4GZywF+oxXMKH6rk4VRTRPw=;
        b=NCg9wNQYZVqjmHnqOXb1v7qp/7fqWknKJL/QRyZYovKQs/myMc4j2AUajQMrS+dP4D
         udSkhVsxUcL0ncRsQcQoUD7oxCxp4Dzj4HsCY4ie58pzH5ogyNozQbJI+P2a6zB2MMTr
         4oifuwvOvaRWJ+HPHuCPmSaX3tqn1rHvwngLP5e6vV7DsYZOtmz3UarXX8mnm2GHfXdT
         073OZK/ICwou+8FOCfyTxIT2AEkS8iViU9HmDTOaiu5IdAQK/O2Z2FazAiZZ+49vMxez
         u36b89EPWyC21KY4U5OS/o2d/wS5fIKtbzwEuDXmqG18AlurdQ0qq9sI8Zx3ifYs7uYo
         fk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751910225; x=1752515025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNTmsp6IOfSThnweAThs4GZywF+oxXMKH6rk4VRTRPw=;
        b=xGimcSLlJsLb3XT3pn36+Z6K7jcJk88VeE734yQNW+eBTGXpe2ZEIX+c5LKsgEexQ+
         UjvPfmQQf+uMCARkDZIveQj89Zn58msK0jxckvIJ33BbGbEmcoWseeZr7Htst5xgxfAm
         ryQqII6ZN7+KvGc5nNyPVOOKabvXrV6ldDjin0IaqgZTW2yu2KvogrvO7mG3ZMOdljmD
         jhPDw7KMfRfWQOte4gV/s/tO7rHEJ3DG2ZEioMCZ8EwzbB6uPN5fKIOQWvOm/2zlbIYR
         VqYBTTIjiGTrrPqB9ir93DFFMGoceKVui00zGA1tO63MeMalYgujN6NHuolzzmKkFSD+
         n8dw==
X-Forwarded-Encrypted: i=1; AJvYcCUB0OyKZIAoTKm3ToXpYJusc6DIXM0dBate16lFJ4jNoCFu1NQ9WYz5/Sq20qkzSU/yzbGf0wJKWY4j/k9/b6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+59s5Ex1NUOnJIM8zL4IzCAFyyQX/2zfdA4CMclOyJVW2EhoU
	ilJpP0yuQxfzyI+kmY2a6mJav297L6s+sCksMiouTPvp3uyiY+y82LFRPClq2oHC509RKrsX+h4
	oJXpTg7x5LRlwj3k4WXQap5jTq91fgNkJ8d3hK/LM
X-Gm-Gg: ASbGncsZngiMuwkMzy8v0pDC7heCiTLr8qZn88GbYJX7FKbSjoO6mPgdmDAnEt1k/31
	xnpT2BvoGHPt9ESc3V37pRDXhSV9Xzsny3Oe9mFL8REhX/XaYm70ttE6lDqlPWA3ND17h77fj0T
	94/sqKhZWnPUxahRdUnS9rGgosbbgjtscQYQJ0XoXgx7s=
X-Google-Smtp-Source: AGHT+IFxRUUAZ3Xaq5S5eJcrS9+Mh+VeOfWYh4AgvwBPepuUuEP/LquhHfhcsDZhanLW79FGlVyFtLGTYE+GzJGoEUQ=
X-Received: by 2002:a2e:84cd:0:b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-32f37eaca8amr1108661fa.7.1751910224859; Mon, 07 Jul 2025
 10:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com> <20250523233018.1702151-18-dmatlack@google.com>
 <97cb1442-97f6-4ec3-a11f-17469355a937@amd.com>
In-Reply-To: <97cb1442-97f6-4ec3-a11f-17469355a937@amd.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 7 Jul 2025 10:43:17 -0700
X-Gm-Features: Ac12FXxCEPEo11jkTQ83GJB2ghGPApHXMozxc4-Zv8TsmCBpYJBiejbyDudmz-4
Message-ID: <CALzav=f1=TvT8cS++x06mtxvrNRJWpKLdKvQ75iHVM673s2ubg@mail.gmail.com>
Subject: Re: [PATCH RFC 17/33] vfio: selftests: Enable asserting MSI eventfds
 not firing
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 5:24=E2=80=AFAM Sairaj Kodilkar <sarunkod@amd.com> =
wrote:
>
> On 5/24/2025 5:00 AM, David Matlack wrote:
> > Make it possible to assert that a given MSI eventfd did _not_ fire by
> > adding a helper to mark an eventfd non-blocking. Demonstrate this in
> > vfio_pci_device_test by asserting the MSI eventfd did not fire before
> > vfio_pci_irq_trigger().
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >   tools/testing/selftests/vfio/lib/include/vfio_util.h | 12 +++++++++++=
+
> >   tools/testing/selftests/vfio/vfio_pci_device_test.c  | 10 +++++++++-
> >   2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/too=
ls/testing/selftests/vfio/lib/include/vfio_util.h
> > index ab96a6628f0e..2b96be07f182 100644
> > --- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
> > +++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> > @@ -2,6 +2,7 @@
> >   #ifndef SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
> >   #define SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
> >
> > +#include <fcntl.h>
> >   #include <string.h>
> >   #include <linux/vfio.h>
> >   #include <linux/list.h>
> > @@ -116,6 +117,17 @@ void vfio_pci_irq_enable(struct vfio_pci_device *d=
evice, u32 index,
> >   void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
> >   void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, =
u32 vector);
> >
> > +static inline void fcntl_set_nonblock(int fd)
> > +{
> > +     int r;
> > +
> > +     r =3D fcntl(fd, F_GETFL, 0);
>
> fcntl F_GETFL does not expect argument

Good point, this could simply be:

  r =3D fcntl(fd, F_GETFL);

>
> > +     VFIO_ASSERT_NE(r, -1, "F_GETFL failed for fd %d\n", fd);
>
> May be print errno as well  ?

All of the VFIO_ASSERT*() macros print errno by default [1], since
it's relevant often enough.

The idea to print errno by default came from the KVM selftests [2]. In
a future series I'd like to find a way to share the assert code
between the KVM and VFIO selftests since there's a lot of overlap and
the KVM selftests also support useful things like backtraces on
assertion failures that I'd love to have in VFIO selftests.

[1] https://github.com/dmatlack/linux/blob/44c8e1e805698286e43cf2a471f540ee=
e75e94a1/tools/testing/selftests/vfio/lib/include/vfio_util.h#L30
[2] https://github.com/dmatlack/linux/blob/44c8e1e805698286e43cf2a471f540ee=
e75e94a1/tools/testing/selftests/kvm/lib/assert.c#L79

