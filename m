Return-Path: <linux-kselftest+bounces-43508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE7BEDC78
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8913BAD3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ABD284684;
	Sat, 18 Oct 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctgfptj2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621EB222599
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760826987; cv=none; b=LdEUHzvGp1V+Vp9Sbz5Kk4RcfdeyzooQWaGTQkvng5Q/pjgEvdxVmaXhxpI1OWcWNyNnFET8mkNQnCkBtvV0y2egj2Xd5Tef68J5JuVJAifWF5khx8qHHY9yK7eU5rMT7p45I0y7I3zkYbSqu+fm83iYQB8jWJhD8S73ZXS2Qgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760826987; c=relaxed/simple;
	bh=pFzf8miSsTyQTIElNQFz1n/HWqUsOyygD14DQhBgn9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COCAbQQ0mNb0n54tH4PHbyBcvAjCTJ27vQkFgD0P2qpmEmMm4oRNgNYfEV47dtjZP+Hpqd4KAEorWUWeqmXt2/jU7uj7NjHT8ExvxfmmTW5giBNuo4wCsgYOngMZFG19TWtnoSGtDd6hxD0YaAaGQ2AP597r8byd1++z//AnbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctgfptj2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290d48e9f1fso133545ad.1
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760826986; x=1761431786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGbB1TR8d5jbyTjinpqncT8Bz5A4q4YggszjBvUfqm8=;
        b=ctgfptj2K5SeM0ChPgRJi1Q8eEHiR+oTqgerFPQvFat900Rj7RLj0J+Af1LcrI9Ecw
         RfccPIlwdbChDQ2vqQKcKGKrQsb22XJxl+SgPK97g0DM46uWMq2zRSQpZrEZT3jEfear
         dSk1QRlq0HsxYCZR7HxLtABc1ZbtfTJ3NsaFlJI148FkiqKbFq+6gcDNX/DWs6pZRFe9
         sxkBrf+AN+Q5BfeFK/jyw7fzsuhwO/J53ygS7iCPDUaSlXCM07QncHUD59ekLuD4q6aU
         tuc+BRQN1LuCBHfel5VofhsJ2vpgRZ+hWh5aIt606RxkzYR9g/wSdICtkJzGCktegTCT
         oKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760826986; x=1761431786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGbB1TR8d5jbyTjinpqncT8Bz5A4q4YggszjBvUfqm8=;
        b=I9Y4YyRkgF7NACfUCoX5Vy9NPU+1ynsN+GYOlxTSS0bVKDZ+svGb03s6qGA9QXPY06
         FhxzThoML/gS7rvLlHCfp5AXCO98ovcj+DED26bVsRUmqtpHCHuWjnZIdgrVs/U/QkMC
         HdltLMR+shgPsSxZ+4jc4rBD+hFa1ojrEjqDcqNrsR//pWRguNSAzKZQjlCDUk2zYHfV
         /T/oY/fECHGw01h/wKrfue1QreaSTvALEpUlzZBpUn6WkNAB2v/GOmfIN2ook04+3fwE
         swKltcMAh01LDmubNyqwLMTDlXqBz06+RH7BStZl/XCpjDrJCqi0kr/xrwYECV/v1sqK
         17Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUoYKD7evxzTEUod3tOeisGRwMUxdGF69wRcelMg0NybTuDEcLusXjCjrdVeJDRdR++n0iGfEqloh2U+FZmGRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmv9tUxAjusZkdox1iGlJz2LfgFIQTmYnESKANQPDH9bsQhnLo
	oAAavVATaJEtg+exH1mayP2MS17nWCx5P/BGpPwglxY1YbZvDnvgPJfPkBngsJoh1g==
X-Gm-Gg: ASbGncuhPmtraDJEv75pQ0zFD4pCHSe6yG1Lktzb+6ed/QUrvJqoO45KYtoxObHYDzy
	VLU8U6XKUtjRVudAV5HmSad0gQATel75BklaNk41ebx5nXkb4TH1EXbQLfEJiogWH2dMzSd6Trs
	R68rHY01R+Xj2r8CeDL1wAsQiM4AB+heywIs1wzqXGdxYa37lrKA9y8wzCcay58VXI9nDMlpFDb
	y+PEgEqKAhyG0cNMNDWFvmFcuXYTdN4tQhWJVrL7pIlJjAZnXY4fsZYtQuwfmtwwiVpDb07maCU
	+EGBc1TCYsHf32gGOQTqU7QT8zrE18xODkNIPjrWRTGM+cfZIh8RMl9AdZYNNZ1G+na057gl18P
	7/eYRJ56M2352kaPa0sVAX3/sCiurrcmdDIYgMZCcgO+eV6wI06HktEYvKo0WvVialP3U5N/9b0
	2TPWLoxBOFUfHRbaS6EPCwHn8hxOIoehgoLg==
X-Google-Smtp-Source: AGHT+IHaiRv9OLO9og6yUxkxhsxdkCBLs5Wc2YKRG+MPA/1ymOP45cWtQ/+Vc19xN84Mx5WD/38NbQ==
X-Received: by 2002:a17:902:c94c:b0:292:4d93:b501 with SMTP id d9443c01a7336-2924d93b64emr1647705ad.11.1760826985060;
        Sat, 18 Oct 2025 15:36:25 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de3295dsm3585285a91.15.2025.10.18.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 15:36:24 -0700 (PDT)
Date: Sat, 18 Oct 2025 15:36:20 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251018223620.GD1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPM_DUyyH1KaOerU@wunner.de>

On 2025-10-18 09:17:33, Lukas Wunner wrote:
> On Fri, Oct 17, 2025 at 05:07:07PM -0700, Vipin Sharma wrote:
> > Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
> > linux/pci.h so that they are available to code outside of the PCI core.
> > 
> > These structs will be used in subsequent commits to serialize and
> > deserialize PCI state across Live Update.
> 
> That's not sufficient as a justification to make these public in my view.
> 
> There are already pci_store_saved_state() and pci_load_saved_state()
> helpers to serialize PCI state.  Why do you need anything more?
> (Honest question.)
> 

In LUO ecosystem, currently,  we do not have a solid solution to do
proper serialization/deserialization of structs along with versioning
between different kernel versions. This work is still being discussed.

Here, I created separate structs (exactly same as the original one) to
have little bit control on what gets saved in serialized state and
correctly gets deserialized after kexec.

For example, if I am using existing structs and not creating my own
structs then I cannot just do a blind memcpy() between whole of the PCI state
prior to kexec to PCI state after the kexec. In the new kernel
layout might have changed like addition or removal of a field.

Having __packed in my version of struct, I can build validation like
hardcoded offset of members. I can add version number (not added in this
series) for checking compatbility in the struct for serialization and
deserialization. Overall, it is providing some freedom to how to pass
data to next kernel without changing or modifying the PCI state structs.


