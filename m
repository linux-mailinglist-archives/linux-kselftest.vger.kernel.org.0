Return-Path: <linux-kselftest+bounces-27086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE263A3E052
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A78F3A6A00
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2521323C;
	Thu, 20 Feb 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK7z78W2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45A212FB3
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068154; cv=none; b=W+3WmdqpAf07CEh1qThPFDJp+kxaTj4ssR19QCPElZOscAC1AqJnumIQp2gCZmDrAjOue/D3ETnKUo/iCbS8hz1ucqzAXhisBwnEtLmbAW1WAn4RCKYz4f+uGpiyyqlHdMcfOT2f1k8B6SbLTgQfYSs3dMwmA8bBqQDZJl6EN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068154; c=relaxed/simple;
	bh=sefj6hxNE4DKzJ9Uo+g0WJ+GyLGTay+PVJVsLpQlNGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/6TsRNJLzDaQDZBpTVNbvMitvmKMKXE0RyKOPy6xHyYuGVMn849uadDPSCwUHZXGNQ+aIf3GGtXK6zFPwTAdHjsHZfCMyRuZwysAzekN+z3G0Y53e2AUh0l69wuQrPgb9k6+jjofiOIiCVTZ33OEq8p8GAknrMa2CUS9XhJW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QK7z78W2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22117c396baso172365ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740068151; x=1740672951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9z6CJ8GEmOUY+R90CcF3D8uqozLmZO9LjzSZXbDX8o=;
        b=QK7z78W2puJkm/e4WzNaLjgqCPZzGmRob1i3JzdKj9aAs7kILPT+75Ppo6D862n3MK
         VmWcg8XZM2vk7vCrYL9kXopU0Bswy/C2Lo4LIEzDQJ6R4ntwFQbDNzQgXhHWD4nKqt0d
         r6zBMYoR0FOmDuWiIR287BWwcADfhZ/QTmwa/6VCeYvqDdn0yRktRMg5itTYTbG7Z71e
         ARFwtCIPAk/l4No1VlYd4u2+S2W59mePHENm10ecvO3CoGtgsDW+b5dqsUHA4vFU/kjD
         XMHsZg+pKUEOJ4IoLjKiBBQyImvhRxG7x9yOxzi/JLcKmL+XXlbxWYrtgVYfuwbkyl9y
         VkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068151; x=1740672951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9z6CJ8GEmOUY+R90CcF3D8uqozLmZO9LjzSZXbDX8o=;
        b=DB3u+/v1l8Mqc+6dv6znsP9XHGGPYURYUfgGNGa+LktFA56oFLTBVhsN1GbmZFXakn
         zC4Ftk5D19OLpQyvy5CfnXaxMkQ+SCiBOkeOJMN8wIYWVQRKJbTVZV9k87+Qh0p//zVj
         mhJgzQFT8vgzWnRdoZPUrtzgv88iHIT3TrIKrEjWIpBVdvj05DSMzvPOtUsF0z0790cQ
         Yp7lZPxlCcJcUj5+CjiSk99AeiLkqC4x5pSRtBAKc6uSciD6GNE19hsPL3ngT7VPOS2t
         K9NaEqH28WOFAksUmG1SjYki7uyRvRs05FW85nTHs1Doyk/1GbFZ1sfzRTmJw+vZsrJv
         A5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWIbrfJK7Gdj3Ajv2IOQaURWnu+7FXK2uFiARmkiPYCB8FxN5KpWW3904RfR2xAPI35ENhfXirxyjdZp7eDejk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlqFT/TZgM+OkW1w1jRUGipY3bgzqoSD8BPSFa049SidZdM9q
	oWLvOiXh8kchjwwk/hAn4bZZWpPdET60GtZdyHxRlSDAdeak7o7M+zFn/L2Eag==
X-Gm-Gg: ASbGncsQo0mvLlXr32pVYAeedxE9ghcSQUrXY+2OH2fIM6uEiIg2owZOA13Ut77fzlp
	EdK34h6LXCISrPQhb4hZB/6DQS4WvorUtfNiEyRsQT9+YveLC2xlTTQ7+JC2I6OtcwKaEBr6+/W
	wWAKfJHGdpUVgRxs9N2nIdJp9RaqBtBWW7zoPslIpgK0F2xAUq7e0iSlsJfaIELHp9HKLvHNKVP
	kx+WarXceGWXtayNYQRjIH47PcLM4hdEKTjM0rTnSvM6vzm0FvMujHd+w9nHoryzyeT7KzPyd4H
	1of/0d2vHVzTOsMd+quAnz8kVXwtxK7eMLg/coXNNlXqwFaPB4vp
X-Google-Smtp-Source: AGHT+IEeeNO5YXG4GrTFzHJDa5KXpncdRPcsXRbYIZYGBm4w3MV78t3++PWrZwNmDnY5dth9MgRnnA==
X-Received: by 2002:a17:902:dacf:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-2218debe8bamr3119545ad.20.1740068151245;
        Thu, 20 Feb 2025 08:15:51 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc7e9325fesm8522382a91.46.2025.02.20.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:15:50 -0800 (PST)
Date: Thu, 20 Feb 2025 16:15:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7dVLNLhP7VfZ-Ph@google.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z7TOq-gIGPY_ztW7@google.com>
 <Z7TXQ9EdyvHp/lmD@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7TXQ9EdyvHp/lmD@nvidia.com>

On Tue, Feb 18, 2025 at 10:53:55AM -0800, Nicolin Chen wrote:
> > > Is MEV available only in nested mode? Otherwise it perhaps makes
> > > sense to turn it on in all configurations in IOMMUFD paths...
> > 
> > I think the arm-smmu-v3's iommufd implementation only supports nested
> > which could be the reason.
> 
> I guess what Kevin says is that non-nested STE should set the MEV
> as well, e.g. BYPASS and ABORT, and perhaps stage-1-only case too
> where the attaching domain = UNMANAGED.
> 

Ohh okay, got it. Thanks!

Praan

