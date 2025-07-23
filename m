Return-Path: <linux-kselftest+bounces-37892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507CAB0FA2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 20:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF74582247
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F1422E3FA;
	Wed, 23 Jul 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3JTOj3tO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F141227574
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294907; cv=none; b=HF8At3HU1Ka/PPvSbSTfkSIuIx1z+VuvAbQ5yp8/un0+2QZPrgEE2rYyyzZ3tAkM0t8oP2YZ2eBFUizWM/trB7X4vi/qNt1NfZC6iwOlFQdiXp3GOQQZiwt+Jf7tWR4FfmjB8t84HxTAbLmis7YG7X2H067HYjg/9jkrUh51lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294907; c=relaxed/simple;
	bh=VqIngfHCPjNn2aJvm/JpMowD1ulG5Y/mqzv4IonmpQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QJpUx/cUNWgwp0gl803b/wIIrognLu2qGOYcG8X2AJd9O4/OvuIci2fKjmkpn9ShmNKLHamqwcWwQGfAL9yVYro/QJ43o/uwX6R9fXf6QNnK65wlv06UmWn/ut0UPuwomAu/p/wXF2JRry3S/d5mVwz/2BJlQDKMtiIq6JhAjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3JTOj3tO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so124998a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753294904; x=1753899704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DG7M6lyjDlWLPjJAB3sObE4Is8Lu2eOsJs2zd5O8jM8=;
        b=3JTOj3tOW7Yt1MCWqdu7IwMjj0v+5YXRWjIdmkdWaI62r2br9zqQkqtPCyEc9DVXXo
         ui1ADSh0WXU9Yo5RgduVzgw6y8RgyRlBkbSeSXUXrFb8oLtUKQ0aHyru5wSzRkhC8a4L
         riqy+raHP1XnR65GLwtW2vVVHM3xNnehrzp1R5OSMxmvgy6Q2PnS9azlG9js1VeoMXR9
         eEu4ocjoAv9kaVduhTbqRaRpurUGegfcn1GE0Q/Ma2crthsvhPso03MQYMB9PAUeDCOl
         eFfTNNCI3V/ozXI4jOsBA1rm3RiFbwuSSrPnHzRcmhqL8zA5GA7ge2VOO4o1yWoL0++N
         kbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294904; x=1753899704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG7M6lyjDlWLPjJAB3sObE4Is8Lu2eOsJs2zd5O8jM8=;
        b=ml9pmSZEke50Z1OIn9gaptOGOHHG9z3q90FOnQ9LRtEm/UjmxAyXFMoG/OkKlchYPe
         24udYe0Fqnnotq9HPzE1eQmZsuXrFmD3ezzQ36nFRu+wWMJNCqn2jQKUlwxHpkPc271J
         cnthryELLeSundPDqKMy9106R6SC2JHf4ZZRMp7dJlnDwKgGc7WYT7brOGTGNpXwTuou
         VHmXC52EenAPC6ezqNbLOebZRAGQOqe6qWUerwS1dRdN0KyNGodse5x3Ne6VW5gntDWE
         5j0Ta0wtypW+Xlpgx9omkJMnEAcMTbL5LCzIJotClAaS+pQAdTWBEj4ZvFv5BddRJbxJ
         mlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR5zHFfupZ+3M9AaYtOj2NW1SWxdrHq+wyZ8LaidFh3MKx6ZTc+rwkfGL32JyTMpaC7sDBphHrDil+fK/Y4z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthfOGpr20coFsKTbpY3MVxwsucD50kGIDYl8ivuvPKX/9VsLv
	T0dd98cFPogzXn0MNmQDyiDdrIBW5g7jbT9p5+CI3kiPp1XGnM2wpY/7Cxm5P/L0pxdwCtXeWow
	OqWQ2BQ==
X-Google-Smtp-Source: AGHT+IEoG6geTciHyN2JVzYp6ADYGYP+/NlO7+c7gYm1psQpKmX7ZKOFLzHimcilfZBXWxvlIN7WpZ2A2HE=
X-Received: from pjq6.prod.google.com ([2002:a17:90b:5606:b0:313:246f:8d54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:530f:b0:311:ffe8:20ee
 with SMTP id 98e67ed59e1d1-31e5071ccdfmr6939359a91.11.1753294903836; Wed, 23
 Jul 2025 11:21:43 -0700 (PDT)
Date: Wed, 23 Jul 2025 11:21:42 -0700
In-Reply-To: <20250422161304.579394-6-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422161304.579394-1-zack.rusin@broadcom.com> <20250422161304.579394-6-zack.rusin@broadcom.com>
Message-ID: <aIEoNpe-LFoH6LBm@google.com>
Subject: Re: [PATCH v2 5/5] KVM: selftests: x86: Add a test for KVM_CAP_X86_VMWARE_HYPERCALL
From: Sean Christopherson <seanjc@google.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Zack Rusin wrote:
> Add a testcase to exercise KVM_CAP_X86_VMWARE_HYPERCALL and validate
> that KVM exits to userspace on hypercalls and registers are correctly
> preserved.
> 
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Doug Covelli <doug.covelli@broadcom.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> ---
>  tools/include/uapi/linux/kvm.h                |   3 +
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/x86/vmware_hypercall_test.c | 121 ++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/vmware_hypercall_test.c
> 
> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
> index 502ea63b5d2e..3b3ad1827245 100644
> --- a/tools/include/uapi/linux/kvm.h
> +++ b/tools/include/uapi/linux/kvm.h
> @@ -933,6 +933,9 @@ struct kvm_enable_cap {
>  #define KVM_CAP_PRE_FAULT_MEMORY 236
>  #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
>  #define KVM_CAP_X86_GUEST_MODE 238
> +#define KVM_CAP_X86_VMWARE_BACKDOOR 239
> +#define KVM_CAP_X86_VMWARE_HYPERCALL 240
> +#define KVM_CAP_X86_VMWARE_NESTED_BACKDOOR_L0 241

Can I bribe/convince you to port KVM-Unit-Tests' x86/vmware_backdoors.c to a KVM
selftest that verifies KVM's behavior for the various combination of module param
and capability values?

