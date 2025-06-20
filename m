Return-Path: <linux-kselftest+bounces-35525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97445AE2667
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA987A40BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7851E257AC7;
	Fri, 20 Jun 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnlXujij"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4232571DD
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461711; cv=none; b=YF8/qFa6vnYb2CEz0eXzjFx0pU/rnzFbcxeNc3zs9q17tXBrFbecLnkmonEOUzijMq+EOlyxOJcDT3azZOKuxAiO86M9Ewhcw/WWI11VRvKl/LIJuzNgDvTMkL22T19asdYC6PrDr8wZ1QHiJ5R9QyAfWcPa+MeiRGELMY1VjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461711; c=relaxed/simple;
	bh=4Rbbdo8Te33eX5Sz2wKD++RbD7YvU4Mvt3s29PrPfho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZ2cSn7xNkw7HLdPxgnWnA4AphkHnEG2eNTrvavNYsDScg2Bz1V84orMUr2Wv9wPNQE/YC0j9MEHjtPpNHrFFS54f011eLrMCo7HAZIFK3tmgfZObdyL/3Lx0QOO6quAn2hWlY83X5TkLQe0HDPHL3SPQYn/r++RpfQaNr6P7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnlXujij; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31814efd1cso1484952a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461709; x=1751066509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ht+lX4FkVQx+kh7/RHmXz1YJN3Tscb/WkZj3g/vKUls=;
        b=AnlXujijB/yNoyM67yD94fWQ88yj32OMGTDLpfvyJQKTInD1vpP9bys3mexPvqI0Xx
         GjttEw98kRsMLqiSotA6BhRmHvhtqdz6ckSE3TzC/cLiAgMEBavoWIsS/MgbT0gtmvvO
         0h0EwmP4Ha9EDCuw9C+1pMbfiH9od+pNhBj6CWB28ZIYWf2RJ17eohTpCJg1aP03W48O
         sJU5s1FWH5HXJhkO0ju0aEEHKmHuQxLpZ2vFGuGdSNfsd6xclDVQgcGLqJYfz824OujN
         B0Z3791JOU+fZGTZAtkOjNdKQRp9tgMbXA+fIiq5311UJMzqgXJamze9fQ72MV4zuAy+
         9WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461709; x=1751066509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ht+lX4FkVQx+kh7/RHmXz1YJN3Tscb/WkZj3g/vKUls=;
        b=rc7JzXbTUOsfshu8deasXq1fq0/UKs7CWHLHggzVdUp+pMDCbbyszqrET3yp1BAy9g
         CQV6k2R53+TPuDBPSOXwvicrCI/WumL9fDeyEUtEOLYICnEx2yiwg66emt1G+ORRyiWm
         Qtja2nCyy8+mALTB8jhddnjv+vxBZ7R3wv8XmO7K3+pRLJkkpUc+FJELAcrqwcaG/saR
         O8N4hZbrRvByjF6J4bzEK0OU1zgmcfpfsrU3R+7bllnytbZfzj4nhsLKHHWssnIfDG/3
         zP9pvA9HsdZI4m9tA817jnFfMwcTKXaKyhAyG2k9xeVLXWjVlvXaNAKdvfmgogdaeFLi
         pGrA==
X-Forwarded-Encrypted: i=1; AJvYcCXe+sL4MESUM6Y0aBayujU9NMC1i50MDVtjQsG2jUXdhZDXgnzz0D7wxoLU7mcGOlAwd6vlhuSSuKMnauhOoDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtYZYEdHphhA/77MRpvV7TR5Wez9UbJAVsuutG21TBt7vgZJW
	EzWW0HyLQZHvz54xRY/Oxw7x1pxbT8C3Pgy1yk9YyB9gFDeWmnsphvarCi4BLP9EtJdGOUG4jvC
	zUwSpiAaXtkg9Bg==
X-Google-Smtp-Source: AGHT+IHk1cqt7wE0Oxy+wOBbkVq8UQ4/7WvohN78dvMUrgmXjRotyYbEbLMWuY7Yt84BPxJ5RaXr3IyOdlBsAA==
X-Received: from pjbqc3.prod.google.com ([2002:a17:90b:2883:b0:313:17cf:434f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d0d:b0:30e:712e:5739 with SMTP id 98e67ed59e1d1-3159d648250mr7675071a91.14.1750461709451;
 Fri, 20 Jun 2025 16:21:49 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:29 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-32-dmatlack@google.com>
Subject: [PATCH 31/33] KVM: selftests: Build and link sefltests/vfio/lib into
 KVM selftests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Include libvfio.mk into the KVM selftests Makefile and link it into all
KVM selftests by adding it to LIBKVM_OBJS.

Note that KVM selftests build their own copy of sefltests/vfio/lib and
the resulting object files are placed in $(OUTPUT)/lib. This allows the
KVM and VFIO selftests to apply different CFLAGS when building without
conflicting with each other.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 57d7a8fee047..5a9644ce910b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -274,12 +274,15 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
 LDLIBS += -ldl
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
+include ../vfio/lib/libvfio.mk
+
 LIBKVM_C := $(filter %.c,$(LIBKVM))
 LIBKVM_S := $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O)
+LIBKVM_OBJS += $(LIBVFIO_O)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(SRCARCH)/%.o, $(SPLIT_TESTS))
 
-- 
2.50.0.rc2.701.gf1e915cc24-goog


