Return-Path: <linux-kselftest+bounces-39512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC34B2FD30
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774FA3B85E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAAF23B60B;
	Thu, 21 Aug 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0nYVNDR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87FB1DF977
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787343; cv=none; b=rBPPIzw7uGjq8zuGOtFbHtMQta1snVoaJ4UzXfVFUq9cm515SlB5kuwWo/u7gJ4UXHdIcdSbbfX0zY9OZeyjjSakDRIGSvQRly6l8uoVUJy5y2flAqleKTSSfrnyfSAuPdcseuG4slKZP0+2cCGNqXlVCbAC9jhKPt8UbJgr1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787343; c=relaxed/simple;
	bh=BX5DAhqdzslnO/91gi/bXKLfgy/01PP5THxGap5lJvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z2Pny7CFJQb0OFqGFaGsfocpdFEkl1iac0SKp0ju9SuY0GEXXx870AjojkCXzcMzXcAYTq9GmNqZz1ZGGDEOpNZ48ERGF5pLEBmkAWm8nyrOwIZzxTxO4pvqmgEYsz/m3/wulyLRqkY0Qw1O42PAki1JNgiE1hD8SSSal0DTjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0nYVNDR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324fbd47789so568708a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755787341; x=1756392141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwhaOsDZKjM31to5aYQy2uwlBTUbbjztbU3kR381HLQ=;
        b=b0nYVNDRA1kOYjQGgCHB5C8rfDce4HmsKtSRI3W36RslK8RxjKxfzISVXA7Tr3duK+
         Vq2n9n9I10HqXr74NS3RJkHugMJbfhnyQfqt5kzklh9qQDStznW5+qK8hUvecm9294J7
         tLCpQgjRZy8iDoxS2JYrHKVuLXcBHc82a4yqd55zaL7JJYQDWtBdjkLyegoo8OpC6wWI
         SKby1HzZdHroOIpzm8kG/v2WYXOCkg+K5GkNJKrGbQ57ZHDvDzovDASldYZ5RGjQpfbn
         V9sPPC2YXHBdtnS+fbAo5+PADkuHN7HukvgMVh1GPstW3aYMajyr20IUlOEWCl+bkqIV
         IPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787341; x=1756392141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwhaOsDZKjM31to5aYQy2uwlBTUbbjztbU3kR381HLQ=;
        b=YEEQegveFYiQOMTaCduXFM3OWVzxTF8s6LeH7dfPAgiET/Z7VvOS49hliuEgmcFiEM
         m1CDeZ4V6lvfuQ9hvwpIcvEDhpwcg8RdeE2mcdKOgAz6BS+paO0yKJ7KqNnO6epNdOrg
         N7zwCMpNbwCiLYDujcCq73QWq5WPTrGHSAAKMztHujcVqUnUoaMK1a6KaTIRHkIMlECl
         4RuEWyjXt4qVQkTucBlIF25eYjqBXqTNYvDvhjMDVlLKl4DiLY6Akbv7CrNWreTBHmAK
         o/xv7uG8VTggElKoDr7q6ELPUWCPD3av3Eq0FEf0gqcIQ1svzxgYL02Mmn8U6OQltEw1
         clcA==
X-Forwarded-Encrypted: i=1; AJvYcCWiy29piXTI92YP5a+jjAKmQDpFWv6ig2VlBrA7/XNXxnrqtGvdPcsh8N8fWvz2IrHZAcEYrkjEHZul6fvV+PU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MltFT/7oxUjEjVEfXNIY6UXRjjQNB0YksuYXKMfybmF6v4Ej
	DvU4KHJE77w8DlzCWRPwiGIW0VA0aa3ziaUo2P+/w5Ohn8ZoKYU1O2lShNP2kOWcR7lUN6cZBkv
	CiVJiyQ==
X-Google-Smtp-Source: AGHT+IHVlRF4YOtCmwKhiHtV/w+adEcX043CzoyDKgxhaqZVVCG0NLmbgeDnpXrLHXuQ4ZYW1MGM4IlOTFM=
X-Received: from pjbse8.prod.google.com ([2002:a17:90b:5188:b0:311:c5d3:c7d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5183:b0:2fe:85f0:e115
 with SMTP id 98e67ed59e1d1-324ed1d36ebmr3436941a91.26.1755787341218; Thu, 21
 Aug 2025 07:42:21 -0700 (PDT)
Date: Thu, 21 Aug 2025 07:42:19 -0700
In-Reply-To: <68a72f36be3db_2a6d02294bc@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-2-sagis@google.com>
 <68a72f36be3db_2a6d02294bc@iweiny-mobl.notmuch>
Message-ID: <aKcwS9uY1WSvM3uz@google.com>
Subject: Re: [PATCH v9 01/19] KVM: selftests: Include overflow.h instead of
 redefining is_signed_type()
From: Sean Christopherson <seanjc@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 21, 2025, Ira Weiny wrote:
> Need to add the selftest folks.
> 
> + linux-kselftest@vger.kernel.org
> + Kees Cook <kees@kernel.org>
> + Shuah Khan <shuah@kernel.org>
> 
> Sagi Shahar wrote:
> > Redefinition of is_signed_type() causes compilation warning for tests
> > which use kselftest_harness. Replace the definition with linux/overflow.h
> > 
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> 
> Thanks!  I've seen this as well and it fixes the warning for me as well.
> It might be worth picking up separate from this series depending on what
> the selftest folks say.

Again[1], I already have a fix applied and will send it to Paolo today.  And simply
including overflow.h doesn't work[2] because not all selftests add tools/include to
their include path.

I appreciate the enthusiastic though!

[1] https://lore.kernel.org/all/aKcqRFWuGZQQ3v3y@google.com
[2] https://lore.kernel.org/all/18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk

> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> > ---
> >  tools/testing/selftests/kselftest_harness.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> > index 2925e47db995..a580a0d33c65 100644
> > --- a/tools/testing/selftests/kselftest_harness.h
> > +++ b/tools/testing/selftests/kselftest_harness.h
> > @@ -56,6 +56,7 @@
> >  #include <asm/types.h>
> >  #include <ctype.h>
> >  #include <errno.h>
> > +#include <linux/overflow.h>
> >  #include <linux/unistd.h>
> >  #include <poll.h>
> >  #include <stdbool.h>
> > @@ -751,8 +752,6 @@
> >  	for (; _metadata->trigger; _metadata->trigger = \
> >  			__bail(_assert, _metadata))
> >  
> > -#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
> > -
> >  #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
> >  	/* Avoid multiple evaluation of the cases */ \
> >  	__typeof__(_expected) __exp = (_expected); \
> > -- 
> > 2.51.0.rc1.193.gad69d77794-goog
> > 
> 
> 

