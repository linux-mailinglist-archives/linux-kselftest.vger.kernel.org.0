Return-Path: <linux-kselftest+bounces-7764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F638A25C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 07:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D23AB2452D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 05:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BC125CC;
	Fri, 12 Apr 2024 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eq9dsrct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50F1B968
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900101; cv=none; b=Yf51TbiZDRTxAXkq3LpSgz5+JnCDKeRAx3K9jMIhaOr+wqk7x5EsuVvkKLQp8h/Y0uD0zXxzCvtN/I3lVBSQ+i+ag/jfiZ1SP5cEf+KMVtjXWUWqR3a2XvVm9pyT++CWg3kKSltAF0oyHPUEJJ/cRHrHBflp+153aCifMwzs6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900101; c=relaxed/simple;
	bh=mekwCTMyUIHf0Fvc6QFOxa55PFHUFQeuRMLlo60az0o=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=haMCIDc30MVden/AeyS01kXRo+smqifV5Uwfthavstx5YQn9ksYLIqjobRokHqx9BiMo+Y3ouUQG4Fx0iY5CxcKnLp3QswyeB3/V6agWnD5hn0M3rKttLehjwNs9omIA00YaTohW7i84qqr+iB8hNGDMp/m7+zXU7RVfiRPANuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eq9dsrct; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso1045046276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712900099; x=1713504899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=40CL73wib6boENITVkOBpqP4qrDROFAeF098K7rCEZo=;
        b=Eq9dsrctp+oeiCMUetYY+mx5187uUTmAAILjPVRkuM/efzVXCL+moLjt3HW46gaFJF
         mIt1K4bqnJPZhfCkbxP3YGzx7H1oDfr24z4inSkNYaHBlT7OVEHLv6KSuC1iG1EP5SE9
         b5ugjNlYD/Bl/gK9y1OUKfxr2rdXutn23ND5+yJbT5D8O1VlhzU2moboODm70h0NZKvi
         tAJvW+8Gc1saTFTD5qk2xFjCdsQQOkndgHKfMllBOjsfK8DYWOa8fSXpuHNLC1Rmitiy
         tF1Hfk3aMKdL2dYncCWa2wItjV4ueOypd5+kyXR0xi5ESg0Jdw04f2QST0Lm1iOQEhSc
         2kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712900099; x=1713504899;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40CL73wib6boENITVkOBpqP4qrDROFAeF098K7rCEZo=;
        b=hNZbg6aenGgMeBBClrEDZN9JNFgCviJzn+IU8upJ98YfpVkga4wFrNiVIgfY3iFygD
         idepVNgjNDoXWD04D0tEjKc8Zw5X/e0cz0RvIhnnsvKlIpBq5Z/ZP24w/A9kKlk5WvVz
         D14kLhKPfjPKeEfwaeH5oXx/ePKGmxvg8yeJEJ9OG/l+qLmLtOYK3DU5AHVDLLSeRd0V
         gH0cKfx5U70JZcfVELDsoAtVNVj3phsNewhu5Ge1UrydjaHZirs8AIqDmQHmVZwWiHMQ
         tTd8GVuYTfNDBmpx/HBAOI7Wc05OKErvwDI3BkWTv3EVDEKZ3LeO/tBbxP24ffJfJM+x
         ULQA==
X-Forwarded-Encrypted: i=1; AJvYcCVQI4FkYpv+fn3D8dQ3hA+cJaQLRKix7fHKFcvqOk/8qH7aZ5NKLbUDlobEa1V7qPrfA2ewLVBg1Wv2NWQow5fOIltPl8G5OrIPstdjY85Y
X-Gm-Message-State: AOJu0Ywe/gt2JBF7Su7yvmqH6qnszZd4/heJwjHWOdO5Ovs19m2eWwCA
	ROCfs9zp6EtPgCXd0HH7qNHfFcIvTt79xCbMKkZlyswK6iGWF+Aij8ZE9ilJumm2oJUmDDkZx5d
	iKumz0H5hGHiJS6slutUpnw==
X-Google-Smtp-Source: AGHT+IHBQ7oYt8rwDGfoTH5mMc+eE3PwbtEkoZpDVDKUDzWTMm/e3olIUnsS49ugB3YTyrfsMlcwC9w28DOEHyF/JA==
X-Received: from ctop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:1223])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1002:b0:dc6:e5d3:5f03 with
 SMTP id w2-20020a056902100200b00dc6e5d35f03mr510040ybt.4.1712900098616; Thu,
 11 Apr 2024 22:34:58 -0700 (PDT)
Date: Fri, 12 Apr 2024 05:34:54 +0000
In-Reply-To: <3d69b44a-8542-4a11-b233-16487e980d54@intel.com> (dongsheng.x.zhang@intel.com)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzttk7jg8x.fsf@ctop-sg.c.googlers.com>
Subject: Re: [RFC PATCH v5 05/29] KVM: selftests: Add helper functions to
 create TDX VMs
From: Ackerley Tng <ackerleytng@google.com>
To: dongsheng.x.zhang@intel.com
Cc: sagis@google.com, linux-kselftest@vger.kernel.org, afranji@google.com, 
	erdemaktas@google.com, isaku.yamahata@intel.com, seanjc@google.com, 
	pbonzini@redhat.com, shuah@kernel.org, pgonda@google.com, haibo1.xu@intel.com, 
	chao.p.peng@linux.intel.com, vannapurve@google.com, runanwang@google.com, 
	vipinsh@google.com, jmattson@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"


Thank you for your other comments!

>> <snip>

>> +static void load_td_per_vcpu_parameters(struct td_boot_parameters *params,
>> +					struct kvm_sregs *sregs,
>> +					struct kvm_vcpu *vcpu,
>> +					void *guest_code)
>> +{
>> +	/* Store vcpu_index to match what the TDX module would store internally */
>> +	static uint32_t vcpu_index;
>> +
>> +	struct td_per_vcpu_parameters *vcpu_params = &params->per_vcpu[vcpu_index];
>
> I think we can use vcpu->id in place of vcpu_index in this function, thus removing vcpu_index
>

td_per_vcpu_parameters is used in the selftest setup code (see
tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S), (read via ESI) to
access the set of parameters belonging to the vcpu running the selftest
code, based on vcpu_index.

ESI is used because according to the TDX base spec, RSI contains the
vcpu index, which starts "from 0 and allocated sequentially on each
successful TDH.VP.INIT".

Hence, vcpu_index is set up to be static and is incremented once every
time load_td_per_vcpu_parameters() is called, which is once every time
td_vcpu_add() is called, which is aligned with the TDX base spec.

vcpu->id can be specified by the user when vm_vcpu_add() is called, but
that may not be the same as vcpu_index.

>> +
>> +	TEST_ASSERT(vcpu->initial_stack_addr != 0,
>> +		"initial stack address should not be 0");
>> +	TEST_ASSERT(vcpu->initial_stack_addr <= 0xffffffff,
>> +		"initial stack address must fit in 32 bits");
>> +	TEST_ASSERT((uint64_t)guest_code <= 0xffffffff,
>> +		"guest_code must fit in 32 bits");
>> +	TEST_ASSERT(sregs->cs.selector != 0, "cs.selector should not be 0");
>> +
>> +	vcpu_params->esp_gva = (uint32_t)(uint64_t)vcpu->initial_stack_addr;
>> +	vcpu_params->ljmp_target.eip_gva = (uint32_t)(uint64_t)guest_code;
>> +	vcpu_params->ljmp_target.code64_sel = sregs->cs.selector;
>> +
>> +	vcpu_index++;
>> +}

>> <snip>

