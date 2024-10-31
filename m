Return-Path: <linux-kselftest+bounces-21260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C09B83D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 20:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E81B21C6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDA11CBE86;
	Thu, 31 Oct 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEP9wUf8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6A1CBE80
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404596; cv=none; b=t9nGgPS5L9pTYfSXZp4n4r4OQUbfVH0gHCE0ahZGLinhyTSjQQ0QStoP990J760765UypW4NeDWA8kTNg8kA+ms6lNXNm61lrmCQ9RByT+jXjJvysyG0cfgvLcgUG7HFUR1Unq3yCPwS2vvFHf5q8DgfAXoxKoeRNaPFzgpmxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404596; c=relaxed/simple;
	bh=scF15DBRDvh6LFM+yJGz6csw0YC4b82QxVRvUgcjjIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tuBf3kjMfCS/UnSSl8+5rIr1BJ0ZRsXTbQVptaYiCvmpAVrdCrNmvXTVD45fCE6lHkFEjBc7UWUUbj5ct5W30sf5335+0Kn/snjaTHnXnylQlrqyT41MA3cf3Ewmr0VrwEXveoMlR4OSE1zdsho/rL2BllHjikwp1IN8UF3UVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEP9wUf8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so2425025276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404593; x=1731009393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJBNJUwhGy6IFJuYLeumtEE8caNJWotKSkO0EVZhaWc=;
        b=FEP9wUf8hnslC1NQFqAn9PxqzIrt8XTcRXc1CctzgifHR6xsfZ7Tw6bfHpZtOXZDoK
         mLH3Hoat99LsGt+sLhjvyh4XgfhVffNnfv0HWtqX3L2LcvKuGSl8byIMM1MEt/uQcTAk
         ltjm4/JD0dwDBlm83a3a5FPRDLr3blWvgkdMmtH6c7l5pHmtWz2uxEGFNDJo/fKznQrM
         ZhzQ6NKXCuhgXfu2aVMDgSUXcAh1duO2vC6EdZApAzbPjkhi6EWNGIxZIzMN55Go/g/a
         jHySlMve48YhzpuVG4Yq0vnI5aQELPaDKwkm4CXGhE9fCsHVK9TnYuWtxOCY5CAh1wNW
         Oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404593; x=1731009393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJBNJUwhGy6IFJuYLeumtEE8caNJWotKSkO0EVZhaWc=;
        b=h35ZlMcQmJsIFSgSira2bJSKwhzNjchVlJ8r69DLli9w/t1aTX7hMMeKpGygnUQoaT
         EDuTSsZPVL8asHbrbKbjRQnUPkYgMsDcUhdGrvOIhyyoZ4G0hsKjV5UzGC80Nu0xCNsB
         0cdkT3nuZUmzineofqcWsSt9dLKlmZFlQSum7O9YB8weGoXTFSJhIi2dvT4LQbOyeeLH
         tuej2uP4BRRie0f4FKIuJ8bdxM+qcAbRIM2j6Gml2j7c814Zh39sWw1Pp1ntpUBVVOtL
         cxKtpGAtbdO2ptLzMiuiD3WVlT6+m0Loq73DGyUAVGaQ3cjkbF2JP6SAqojBtez9CvLM
         ziuw==
X-Forwarded-Encrypted: i=1; AJvYcCU9VGm5h3/0KWK0VpQhskq4SROxBT0oAZOae+4z87vDrr0KfeezMTbUNlGi/q/i22yomumYwHWg1btye0wd6vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykyMprSSM1RqCFBftqLEEG3Ko+gyS/+xqtXhfsSurBGbsV9RPa
	NrUTn6iHy5XzlmJK8/Cz8iSR5ihCjA+CpVlFbh3UsZ7DPCiGtR4Jv4/OyIonuLRZ498u5Yf2Q3q
	EKw==
X-Google-Smtp-Source: AGHT+IF5mY8H8HWNIZUe92ntcTAhodfObTAzfmyjPW6IHcMnBhuTa1ixQoAbbew71W7KOu+g/mzrj4F22KI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:b28c:0:b0:e28:e97f:538d with SMTP id
 3f1490d57ef6-e30cf49bcc3mr5142276.6.1730404593224; Thu, 31 Oct 2024 12:56:33
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:52 -0700
In-Reply-To: <20240913054315.130832-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240913054315.130832-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039503050.1508303.8326452918836844664.b4-ty@google.com>
Subject: Re: [PATCH -next] KVM: selftests: Use ARRAY_SIZE for array length
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 13 Sep 2024 13:43:15 +0800, Jiapeng Chong wrote:
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> 
> ./tools/testing/selftests/kvm/x86_64/debug_regs.c:169:32-33: WARNING: Use ARRAY_SIZE.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Use ARRAY_SIZE for array length
      https://github.com/kvm-x86/linux/commit/f8912210eb21

--
https://github.com/kvm-x86/linux/tree/next

