Return-Path: <linux-kselftest+bounces-33726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC0AC2C60
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8E41BA12D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250D22CBEC;
	Fri, 23 May 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvwhhDvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426332288EA
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043076; cv=none; b=SQraAL47lB2t8s5ckZasvcxS2zQjPuAdSQd0JpT9rDf9+GpUFISElGpcQP0r/9753PgdX/NQjq/VaiOOwfYNT6jvsaNquNNtAuZrpb2be3eORi3G5XSl9nCTpMhyeDKbGDNR3iwMFf09axvjnzA7/+5KMaNXQDNIWCE27vFahe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043076; c=relaxed/simple;
	bh=DAWskm27fuqrexunKfw7hlYhX+xBN+WRyq42RSxSiHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IH1D3LL8zNdsslzpIMw3foq3UbJJr3Y2Scj7S2hlIx+NtpjYw/gof0dLH7CBGQN0eXPOgQWWJqBUOZrNfvG9fhjXANsWPK1tUHWAhRfXcgpxXMGlz2jo0MJQOxv288eg1Fwg6hTpsbDI/5p2sg002uQS8yVKlVJHuKz5kz5hNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvwhhDvp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23202dacd94so4833175ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043073; x=1748647873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkfzIEiQP12AqfoYTR1F5iroWEnqNbyGGqI+9c5Fw70=;
        b=hvwhhDvpcFf/LRVYb+aulSl74A4Gv8qhu8cvSDS2gn4mgwJDOc3KKvPnh5LDsYab73
         P26tqdJYxdSTJ/DAxJgg8evJIn2IcTBLFy6EZdawsJL1eVvffE4S3EzSeInFJfl+7p/r
         Fm8qhZbeDCZozqwhLdePdu/nb/rWXzX7gMbdCOB/VvxifJupD00f6lHkghU0/RzzEgxL
         3Q6PqR/6EgLy7y5ppFUpOZDq/IQB1HKSmDOhiJQ0aTJ8wYcF3u9u0H51EqJ4VaZqUSyZ
         8rV50EW9P5a7Xiw3Bn7425/Ysk0opTSJpiVgocNFnTuGOYvpkpEdpN1RRIj6gYY+4KW2
         5I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043073; x=1748647873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkfzIEiQP12AqfoYTR1F5iroWEnqNbyGGqI+9c5Fw70=;
        b=vPt6eSazyX4RZn9XmYlT5DzFqn22sSornjOOv+m0jGf6xfSKM5dH8uOuz+Kkzu0uMa
         B/DTcCw8g5H2/IbM6zGdiLwYvHhDxGi70SProaYdUZACexkbqOYtzE6mmXOykb0gQxS3
         WC5YW7CV4SAljZUR2iqjvWa89vjboW1KfOCuBxtphM0uRB5XDvPsIdNZQ4G3jRj0i+qe
         VHLUHKrGcrdjf4/T3uJsS7T8GoxVRXKuC7mHgtwAJlkdjzyQz4W1Dj8KOHJIo8ZQ+Q73
         goirYxE1DDDtI/dLo87XGOYa633gPX6cOR9oz0arisq58f68J0QFLvEWVJuNh3kxNWHh
         4Vcg==
X-Forwarded-Encrypted: i=1; AJvYcCVuRoyGaI49LALeYumT3dp8a6XSLI529C+NhhLGhd1bGWWYnjNo6KX7cQPhA54CbG/T8k35saCv2jQo5wodKoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4RJJL7qsXzNLoosagoxcLoP0cg4+Pl/7fp3ZjhLt3xLYFGfm
	UAWpgDEGF6A08AS4FlGGthPGR/GwBzFpJ2kdxhT9/AojpJ2Li/0vawBWTxXRB8csAgIgnYzE3Fm
	F3d/jMGlg3GqP0g==
X-Google-Smtp-Source: AGHT+IFzO7OjMkXaL4rEwqaamuxhJjG5KKXFAt1EzMEKAU4Dd7G9aXElHl7IXHhqg+ZCo4NgkPw58plyDAXDOA==
X-Received: from pjur3.prod.google.com ([2002:a17:90a:d403:b0:2ef:82c0:cb8d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf04:b0:231:c9d1:962f with SMTP id d9443c01a7336-23414fa45cbmr18303725ad.29.1748043073697;
 Fri, 23 May 2025 16:31:13 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:16 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-32-dmatlack@google.com>
Subject: [RFC PATCH 31/33] KVM: selftests: Build and link sefltests/vfio/lib
 into KVM selftests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
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

Include libvfio.mk into the KVM selftests Makefile and link it into all
KVM selftests by adding it to LIBKVM_OBJS.

Note that KVM selftests build their own copy of sefltests/vfio/lib and
the resulting object files are placed in $(OUTPUT)/lib. This allows the
KVM and VFIO selftests to apply different CFLAGS when building without
conflicting with each other.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 065029b35355..85f651743325 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -252,12 +252,15 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
 LDLIBS += -ldl
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
+include ../vfio/lib/libvfio.mk
+
 LIBKVM_C := $(filter %.c,$(LIBKVM))
 LIBKVM_S := $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
-LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
+
+LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBVFIO_O)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(SRCARCH)/%.o, $(SPLIT_TESTS))
 
-- 
2.49.0.1151.ga128411c76-goog


