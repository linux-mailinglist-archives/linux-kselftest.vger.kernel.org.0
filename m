Return-Path: <linux-kselftest+bounces-27480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62792A44717
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4744116990B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F0620C031;
	Tue, 25 Feb 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyLnmGI5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB1204F77
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502081; cv=none; b=RmvnL1/5jiEGXYHbl+kQjd2hDcMtfuAdRUdF3rdrWpL8nvU3xOxIVgj8jhqZCHMFIXXH5nCpoQnZbIhF1YZnmI1ZOtKTBRimgJOznIWZL+hzSPKLnGc8HsZVNCtN9wFgu4gvfv0oTftvg/fpsM1S9Vkzlh7ckDGAw+EPKYqqPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502081; c=relaxed/simple;
	bh=6iPgSZh+iO33nHQzseddwrKUrNhaFUNY8ua+PPksf0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf+rly8FoRUxshCF1pA01fBUYO3waq2v075xdEPbnwwI4WrfTzUR6w6euSCPUva99ISBaOlGypIaXx1sznXAIaHACQpG2CGvpMQSt7/OMj+V8YCyErW4wy8y8nt2ww50MiWkpgUDwG3pCHulBU9cyJkG5NYa4KuD2JxgzHW2dWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyLnmGI5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e0575f5bso216755ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740502078; x=1741106878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TXPG1g3tHBq7F0JV2QmBmMxnoyZNN73F2qMEQ/D5jc=;
        b=HyLnmGI5H4N2oXfYeACgsRbk6UslRc3vF9u87tf2wF5YS9nmKpLCeeu9ZExlk/194a
         vr+4BDxkPsG/WQgC6FGFkYXXeQseyunoIkWLBao60GTY7g+hzfhpGK+p0nJ9W+16BMUY
         n8wIG9DZnUgsFH/F38O3no+vqn81YfDsNSp1Nh+CNPgiiRda0VFeT48EWiYJIUFYNyDp
         pJzVXxegLyq3dUWSrTQtn0FOoG4higfGBUu91y6SEwPBOp/Tdqjf6uAYfQO5UU23KhRc
         E7+oqvXgo0A0TfSLilItGoL/v/o2sKcpcd/ELRz+so8korttVGahuex7slTkVjEKAyHf
         4Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502078; x=1741106878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TXPG1g3tHBq7F0JV2QmBmMxnoyZNN73F2qMEQ/D5jc=;
        b=IUvnCA/ZWw7owoBRpGU0T2VZz9vkeOokQpQRcWmHJ8RWVSCDUMDK2MqAaV/F6jwFti
         G7CgSyTSE0hIYgFq1Tl2Bo2kuTd7qYPlF8/q1fZJhgcxuyCdS7G/0udy7Cpy37SuylvI
         c3ikEY/tGMLjWZvPRT0LJmcvOiRo4DEoSpWi8nBRI3dR97G51F6fgonzD/wYAAmzVZBe
         B1WTcKgNil77OvMUyzc+nM/oPZZkndLXvEZoY4JpMoa3Il8nHF3Drjp4Hie3/eJsUdwu
         7HlLpLjTAvSyDNznw9PKDUtttZPUDEH3NiXdYw/56pBrghUuRDcFtlf0CXuHQszuFBFp
         IqKg==
X-Forwarded-Encrypted: i=1; AJvYcCXETaRZVW7dhEVChhuYnGLvZlph1hU0JDrj0DyOHzBTyGNMTY/cYkeseQEUGVqdB7c+ldCSL4rZkiVI44IvWYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkrCZJKKm+ZvGI0Nr4y3XHKYSK7jx3rg1soxTM3W5KGYMBB19
	OSnslYYH5PeGoCQtlPFJ0PsWtS6ay/dUm9L9eacZ0b5D423p8/O9RT1gfGiv8w==
X-Gm-Gg: ASbGncvOA6QONvGuSJiXNDFDFSAkFueAS77PpJsHi0Xb5ZHzyJhx68ee3SQY4n6yR4M
	PewrUepdmjs3EGaWp5uEkqCNp7m3yCCi86yUX0CA3XMHlFmW+/oUNSxaqal05XRrLaoxjNyKbn0
	WEaPvt9XgJXlUe4J8LBacLvafsj2924BD7+AZQ78ckWzr+ITCbQR7g6/x0UF8QCn8pRyKC0Ge5E
	ZSP/oLhcGivHgPvtkNfSAMHz9lLx5LXh+ahYu9LU9+bYv0MkCU4J390tLYwKgXxc4FzTSBJtTjs
	DP17m6HnZGAZ3h3dq3t3PEnIcj41l7vW6oIk1oM2YqTK5wGaQBYFSRrXOU4sVUc=
X-Google-Smtp-Source: AGHT+IFvXw+OvC4N/IKxwnR5Ayk0dG/Aagp8HSvp5fGkA6z7Brsy0CGy7v+QNECgYTSPzGrZqtSVWw==
X-Received: by 2002:a17:902:ce91:b0:21f:465d:c588 with SMTP id d9443c01a7336-22307a60c47mr3818095ad.14.1740502078043;
        Tue, 25 Feb 2025 08:47:58 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095f02sm16558235ad.152.2025.02.25.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:47:57 -0800 (PST)
Date: Tue, 25 Feb 2025 16:47:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z730M3XptvDRObBp@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <b1930038cf828dc13c080e2b46b3003a8c98ef24.1740238876.git.nicolinc@nvidia.com>
 <Z7zmErar4YvQSSxw@google.com>
 <Z7zrHn3tPBD5chv1@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zrHn3tPBD5chv1@Asurada-Nvidia>

On Mon, Feb 24, 2025 at 01:56:46PM -0800, Nicolin Chen wrote:
> On Mon, Feb 24, 2025 at 09:35:14PM +0000, Pranjal Shrivastava wrote:
> > On Sat, Feb 22, 2025 at 07:54:10AM -0800, Nicolin Chen wrote:
> > > +int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
> > > +{
> > > +	struct iommu_vevent_arm_smmuv3 vevt;
> > > +	int i;
> > > +
> > > +	lockdep_assert_held(&vmaster->vsmmu->smmu->streams_mutex);
> > > +
> > > +	vevt.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) |
> > > +				  FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
> > > +	for (i = 1; i < EVTQ_ENT_DWORDS; i++)
> > > +		vevt.evt[i] = cpu_to_le64(evt[i]);
> > 
> > Just thinking out loud here:
> > I understand the goal here is to "emulate" an IOMMU. But I'm just
> > wondering if we could report struct events instead of the raw event?
> > 
> > For example, can't we have something like arm_smmu_event here with the
> > sid changed to vsid? 
> > 
> > Are we taking the raw event since we want to keep the `u64 event_data[]`
> > field within `struct iommufd_vevent` generic to all architectures?
> 
> The ABIs for vSMMU are defined in the HW languange, e.g. cmd, ste.
> Thus, here evt in raw too.
> 

Ack. Makes sense.

> > > -	ret = iommu_report_device_fault(master->dev, &fault_evt);
> > > +	if (event->stall) {
> > > +		ret = iommu_report_device_fault(master->dev, &fault_evt);
> > > +	} else {
> > > +		if (master->vmaster && !event->s2)
> > > +			ret = arm_vmaster_report_event(master->vmaster, evt);
> > > +		else
> > > +			ret = -EFAULT; /* Unhandled events should be pinned */
> > > +	}
> > 
> > Nit:
> > I don't see the `arm_smmu_handle_event` being called elsewhere, is there
> > a reason to return -EFAULT instead of -EOPNOTSUPP here?
> > 
> > I think the current behavior here is to return -EOPNOTSUPP if (!event->stall).
> > Whereas, what we're doing here is:
> > 	if (event->stall) {
> > 	...
> > 	/* do legacy stuff */
> > 	...
> > 	}
> > 
> > 	else {
> > 		if (master->vmaster && !event->s2)
> > 			arm_vmaster_report_event(vmaster, evt);
> > 		else
> > 			ret = -EFAULT
> > 	}
> > 
> > 	mutex_unlock(&smmu->streams_mutex);
> > 	return ret;
> > 
> > Thus, we end up returning -EFAULT instead of -EOPNOTSUPP in case
> > event->stall == false. I agree that we aren't really checking the return
> > value in the evtq_thread handler, but I'm wondering if we should ensure
> > that we end up retaining the same behaviour as we have right now?
> 
> Oh, it looks like -EOPNOTSUPP should be returned here. Will fix.
> 

With the fix to return `-EOPNOTSUPP`:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

