Return-Path: <linux-kselftest+bounces-43629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF0BF3F33
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 00:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822BC5420E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F22F2612;
	Mon, 20 Oct 2025 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHoCQRDC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876442F0C46
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000005; cv=none; b=qQywnvXHMrbd6BXc1UbnSm0yw+aQ3K0jA6UjFP8RAv4QL+ORbamjRyyR7pNrcKgk40ADWfiplKm0tyJi5LerYtnc6lcSa0GGXdMPxBwuNOEJOSSl8YSZOCOyZliN42pdGMIjELkwQF4Q6aHAfc4K9nMLbijB4Wi49pOupYGKeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000005; c=relaxed/simple;
	bh=Tgo1ln9Y6VE+gmfHVXivughYL6jpYIM3N6Z1Efok2No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUs1M/C3szWsU5qPamSsX8cDxLX21bejSiSTFPVo8L9ckDoFEOm3SdAZ9s9iRoZPpt2O7z0LtOLvmYevDlfrFwMGgzevWktbE01dQ1zwJC4M9gLI0SDL32S3a493SXXchmfYmKYWmHrxwk5pnoKwBsx4nEGif+D8bvncmFx8MFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHoCQRDC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290da96b37fso46545ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761000003; x=1761604803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqANdouNpfXe1TpRYeq8OtUbMCXC+xuGaNpt4ay/34I=;
        b=kHoCQRDCLAqY+/x0NIU6c3OeceXwFh8uwuWbvIggH0Zz4XqRyglBIM0JiG0JAG8S49
         /fX4XT6jB/t9V46/BMVXE0O4vjuefOUJAGgoYk/fh/dgATD0etjtAq/PkL9BqqP9Iz9+
         tENviSWhG15OZzlWEyLobHukGWpovdXWTIfIPIIUW9NEW46RWKX+8MF4c8vJkvtHieO2
         cO/ESgKvyRynBmu3Yh79rWorIVUxRZhEnYcgy5C/jdrfn3ajv9gc4d+hUBUTvBJqPeRb
         bwD8saoLyE7Xwb6UpmR5yt39lxS66WE0N7gKLMJ0ireDzuh0lWoTRfHZ4YYTF/ZeVVlA
         +82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000003; x=1761604803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqANdouNpfXe1TpRYeq8OtUbMCXC+xuGaNpt4ay/34I=;
        b=ROwTecOnUIV3jI351dqp3Dl9PO8c5A8+G6jsecCZmuFqrPGdd2pNRGD84y3lAke3q/
         XUcU1n1dKllVVS6g2jBPDtvasTSbdr4WYnnkS/qWSd7VQtdp7WiNKzlsuNzWQ66H9CG4
         4IxfKRm9FeDAnt1YPNnoGzxGpl7fCvmhHlK9AqH8Q7PvosDjTXN32MM4dvUC3fBqiUxn
         xbWdefWuapYDh20Qp+JZ2/JkKKyI5XM0v3GVHZvWoIIexbu3Fn6Z7xPnDSnw3s/3hxTz
         6Gk59CJ8V8jn6/k96oTuYDEVMKAfwWqmQLsYb7MpLXCWcYi2QwRZY4Uin1PN0FVv7I3h
         YNQg==
X-Forwarded-Encrypted: i=1; AJvYcCXO9d0oi3fxTkH3sf2Xl4ns/PRflQJU8cXsx0ij6rDnmWDtlGRzOP9Pt+cdUjOQNmgfOnCC4tBrKJjXELbxakg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSABgi0q7eXJw8bPNiXjUy/DnQtsEplqE8EBXwtICmQUqd8nSw
	VVIPxKyaAZb5q7AapYuFDqDscBwffNkGYhuXtsdUnrn4uHyLccV41YYdG45GOwXCtQ==
X-Gm-Gg: ASbGnct1qQ5SHAdaBVp+P5XjjZhZmULepYhB2g2fj0YtcLSfjOa9s2SMq63r4Ev5M2F
	5PIOp8F30WIcPxcH8Qw+gTCw+0qTE4t9o90EIldgH9jB+rli18VXvH+UWHeSvNWvkYp8lmqtZh0
	kC7WK9ODZVlIa8U9SITRyYT+J4xilQGjULDqxna2Qvn70CSZ148fhgruzJevTbiw51l/+yw+8Qw
	7UU2YQPc+vNWKVveKk6VMDLhzMIgYSnfOkLEMOhzc3xDHCTJpbIPevmY9/PnM+RROhv3oRNky7g
	fJe/GYrgbZkQsZ/6DaJC4PNPdKQklQmpZA1ZY9pin8Im+p8N0q7/MxoSg/ueG4eYrWjia3ZlLA4
	LI4ncpLTR9VurVTnwkt580ETnO4izqeoRjNQtoNq4skBTH61Xlj0Lnvn/xUfoTvA6TJEfvzRk6q
	bHKVF5YN6bNkSxFAPcoa1nKybVk17rXb/nrS0S
X-Google-Smtp-Source: AGHT+IEcqTlHp/Qpfza19a+3ciBdyb/icBOnAmIupjsmC3a9l9OFGVEdaUxANAVMTmKc4io99zwLcw==
X-Received: by 2002:a17:903:8c7:b0:291:6488:5af5 with SMTP id d9443c01a7336-292de2e477emr479535ad.1.1761000002470;
        Mon, 20 Oct 2025 15:40:02 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdee2sm90693775ad.92.2025.10.20.15.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:40:01 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:39:57 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 12/21] vfio/pci: Skip clearing bus master on live
 update restored device
Message-ID: <20251020223957.GA610352.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-13-vipinsh@google.com>
 <aPapy8nuqO3EETQB@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPapy8nuqO3EETQB@google.com>

On 2025-10-20 21:29:47, David Matlack wrote:
> On 2025-10-17 05:07 PM, Vipin Sharma wrote:
> 
> > @@ -167,6 +173,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
> >  	 */
> >  	filep->f_mapping = device->inode->i_mapping;
> >  	*file = filep;
> > +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> > +	guard(mutex)(&device->dev_set->lock);
> > +	vdev->liveupdate_restore = ser;
> 
> FYI, this causes a build failure for me:
> 
> drivers/vfio/pci/vfio_pci_liveupdate.c:381:3: error: cannot jump from this goto statement to its label
>   381 |                 goto err_get_registration;
>       |                 ^
> drivers/vfio/pci/vfio_pci_liveupdate.c:394:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
>   394 |         guard(mutex)(&device->dev_set->lock);
>       |         ^
> 
> It seems you cannot jump past a guard(). Replacing the guard with
> lock/unlock fixes it, and so does putting the guard into its own inner
> statement.

I didn't get this error in my builds. I used:

  make -j$(nproc) bzImage

After your email, I tried with clang, using:

  LLVM=1 make -j$(nproc) bzImage

This one indeed fails with the error you mentioned. Thanks for catching
it. I wonder why gcc not complaining about it? May be I need to pass
some options to enable this build error on gcc.

