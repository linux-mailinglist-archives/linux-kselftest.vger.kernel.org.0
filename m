Return-Path: <linux-kselftest+bounces-39261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E69B2B507
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 01:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FAD52308B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 23:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D812417C3;
	Mon, 18 Aug 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpjsCACT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7701A8F97
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560838; cv=none; b=oysftznoQt8OeT8bV1AZSXzmydB81aOXDRRsCcgwADxm82GHVL7guMNcBJPb9H/63+NxKotEor/t4lb76qfNPGq//E4WJ+Jh32gDPOyGEf2pb5/NuaUC9KyFe6N3jtutXXHcLsKFc+JthqFUYSVbfc/XPylXkHRrHejAep63Btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560838; c=relaxed/simple;
	bh=Jh2c3Xgv7k+vbl3jw8SfiKBooJ7lBXdpty8Vh46PmPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktleAqH4hRpDYyQARMBNHyeumKbBwLnS4cgrA1uiRa4zmLYfT7Wpa3ie1Ji4nklq+4jcErr+oPXFSKvPM3/+hFr+tkC220rPyMMWydwDegqCwOuZj5/jEZifQUh6fDQLk5Q1t0R0oqxetqra5fNDU1OMf6zwBuQ/oA8kRTPDROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QpjsCACT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f92cb94eso36688981fa.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755560835; x=1756165635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh2c3Xgv7k+vbl3jw8SfiKBooJ7lBXdpty8Vh46PmPM=;
        b=QpjsCACT1NRhd6pqker5TfK8rCFyGwg91wpqJD+hZokfs/4ARt8nS2vS3H7tolWczc
         TPJTwEXRpLYdobGtUKIeZJN+ncW7zP0DQNqS8FCPcmyRlzwzRCwytCdjeYtHFXEbkEAv
         8GqEwZtNIiNp7FHrdCZQipOSljLaz1LBD3wxdyuEHhhFK0korl8fDF6k28+RRzUSjn6O
         YSMZT9B5szpmD9jxglEBQo+2r3gOAd45d/jQ9A3BNDECj6aRfP7KvFCbaVS4Aqb8S1hO
         wSGsI8P/YbPqRjr/1BctDuQTwXQSUClKMKXfgQL/EOzh9j83mPumSa5B87cUJ0cgm45X
         R8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755560835; x=1756165635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jh2c3Xgv7k+vbl3jw8SfiKBooJ7lBXdpty8Vh46PmPM=;
        b=qpEYkpXUd01YOwmT32ZUzp/UnVnCdFiLGGYo4Ztd5vXYtC+JQnNwJsx1ggFIHcS5pl
         LRVpGN3aPHX/cS4j/A01w6C4ObFB3nRdzgBmh25HVbRNzxKDlgmQyiPXAO01QY16ZXjY
         riBvaM3ceOMn1HRqQEy7fV2qt09CCzSRh0j9UIRJWTdmb1iOSAjCzszMdfnTw1PWrw50
         iL14tU/mTSiXusW5Wra/74PHTb+1K83g6u9uvWyl513maumnNdk/kCIOq4UEPOnbKn04
         WHWrZOJKmVkgW+ka3Z1f0H6elAUqmvst5aN0jSQvlq/jDxBhzOpq/O9PNUaezg9UUo8q
         UCOA==
X-Forwarded-Encrypted: i=1; AJvYcCVYjtrkc8YA1o9i3ca4b9wbTglujjPY1kemwqs26bdvpr1zlVMgijppxwsn4KkiTTq6xvl8418CY8yFGLaqk88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbH8mKytZpqzlvHTdNjbX5oZMWD6PIpuPcOsq/bCvrI+It4dyL
	TwBD26ZPwilcj2YAsyInnj06Gh4l7UrZEUG4TxlO1lhrbuUuHcYjSW7ncwH8i1MCqsMsiBzSVv3
	ZeuUevgaJKQH0ibHtrmCsCxQzHg0cWHd6x/W9BYq1
X-Gm-Gg: ASbGnctdGldAOLPWQnooYKRJNbc0/l1NRvsgiNybYHJjqSLlVnB27aqw6O+kuQ3sMpU
	nle2YA5IlN8T5igws8bzFSr0zGjT8LH3YlUxZVq/jMQ1etziyMJdidFZAg878s+g78WK5XohIA6
	TjwsorhL4XSxS+t0G9sqhd3vS1J2THTHp/EnGbRrQBslWKOmGtGZOd/X/bJsGnAm22DBjwQ0pdT
	o0hX4UrDsnuE/sJR//8agim
X-Google-Smtp-Source: AGHT+IHOfhSl5Cs9AtJcBsjDbujYEyScxuL2NkyIn9iTc+B9ASTbSmneYkCeqWiBvFsZ6EG7khf5SYWDM+bYwtXqGoA=
X-Received: by 2002:a05:651c:1986:b0:333:aa78:db82 with SMTP id
 38308e7fff4ca-33530725c56mr1368701fa.27.1755560834452; Mon, 18 Aug 2025
 16:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <20250620232031.2705638-13-dmatlack@google.com>
 <87jz302owi.fsf@intel.com>
In-Reply-To: <87jz302owi.fsf@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 18 Aug 2025 16:46:46 -0700
X-Gm-Features: Ac12FXxTYkl5PEdMv5V_lQlu80HYiuMyLIbG5FcXK_PnHOYCMwQD_4jK5F8u78g
Message-ID: <CALzav=frg5WqBNYWSvAsKJzR=kvX-fEMBuGid6ibxSwnw5_nvg@mail.gmail.com>
Subject: Re: [PATCH 12/33] tools headers: Import iosubmit_cmds512()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>, Wei Yang <richard.weiyang@gmail.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 4:25=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> David Matlack <dmatlack@google.com> writes:
>
> > Import iosubmit_cmds512() from arch/x86/include/asm/io.h into tools/ so
> > it can be used by VFIO selftests to interact with Intel DSA devices.
> >
>
> minor: perhaps move this patch to be near the one that adds the DSA
> driver? (in case there's a next revision)

Will do. Thanks for the review!

