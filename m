Return-Path: <linux-kselftest+bounces-39045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F5B277B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678F97B99E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC31C84C7;
	Fri, 15 Aug 2025 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cg+UZ6ND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF65134BD
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231390; cv=none; b=LZLrKozUAHsg2iOVbYcH8nSniBi6GJOHp29/LFGJIfbwcF9n+T8gL4F8n0PkEEim9ylCOJGBOPssoXjB+iMXu8R/LII3xRhX648uDaqvcKprmG5QbhZ9sdAnXmW/6wklf6s9dFbD2ltfDk6NavTVDnyBBULw4ht9SBVCTztBdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231390; c=relaxed/simple;
	bh=O/FxN8kn9NYDBV8o1U98GYZDA4orJ42IZyhISfK8GTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lab6dfnaI/0BDsai8rvy7bdVBcoLxgu9qjkXOzejXiW96pE9V7rxf3iBfnTSwsPPLTvLhgUqWCZUC86Tyir3dnY0qqCEhabPBWOnSO4gHZL6Es7vokT7V7Qh7nqQuGL4MnOb5JNIIQiigzXzsy5UZIv8sJJYALYOAHaZYl7MyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cg+UZ6ND; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b0bd871d9aso193111cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755231388; x=1755836188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpDFenZ92jmpl6OY4EnKwsw0mULhQnR/+GZQK02VdBA=;
        b=Cg+UZ6NDBN2hB3Xb9tmSNLf4pcLTWP+wNZWnkKt96aakq+WwnEhlwRuGrBFxu9bsh6
         HxPgH/lK6Q1J4vaJ/9TrHiNlkR4KFtcinq1osSIeShCbXJ7biJgLzeO2GIAZjyvf9Bdc
         fjzHX1y3FU2wShNKsM4hvzX82eKjiDUQHovKrAwcOnq111QBSFa9HdvlzHj6oW2MZBEl
         X5mwCexaZzq7jGWRhI/0JkwEkE8OlaBh0wwWMtMxOSZiQit0J1qYTmzDwSxgkuVtQ4qw
         GF4Pbbm+gfghWTu/5iYYN/12dewzbc5NY7Qkp5v7nheTZVA5ki+n1v8q20PfeRNm22ZP
         S8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231388; x=1755836188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpDFenZ92jmpl6OY4EnKwsw0mULhQnR/+GZQK02VdBA=;
        b=MWK2PSleJtgftNy9kkxjSEpwdBhYS+PAYqGlVr/guP90anRjSLule5bQDEmdia3dBn
         Dc4uP6uuDv5nyAzlvwEMktKumWVhVg9KDRd+rt3EeSWV8t1SLER9MA2z3NlGeWC3gsNl
         mujyVauEPtENAPCJJfZKf29MnOup1KdOjiL/aU08DBRfK0GeaogGJ5u6rhSfJukSTUp5
         iJIc34dV1ik73Sv/hbzn9BlkyIoLb07EeSJY27OLpe0ecRG3yvbj2YMiFOrRGtu7isCd
         ztdc0QLC2tAYdZZI9Fp6JW3+jF5D9g81L5e+38cqGXhnT2hqw+Gd3fQt3Ixa/O47Aa+8
         RNNg==
X-Gm-Message-State: AOJu0Yyd/zvXu+v3+zAMPxS1sRRDL1vGFBP99Pbak+KG2fMbw6g4TtzM
	eVU2WIbL0i0EF+FoJ0I8SIo32rxspWarQ3gKICqXEvUUULoIBgl1tmd0tMiKBNwioxnrJTrkWgR
	A43A56a03Z3mTbevFXs7vUA6DXtRjRiu/rmILJ9vE
X-Gm-Gg: ASbGncvFnOfi/y7OGkM/XwM25HXUm6eLvq3MlLIbf3S3+6z0hsz0aD7F3bAOmGpJEeh
	NuQcYLaJOfLe+A3YVqPPQZNCJ/D0DHJR3q9Ps79xSQ5RspHzc/4s77apVvgc8WQWz+7VQ01ZwxL
	Lw8xzBNNjkwPbiuf1eYrQyPmwi8DbqDu0pE8aeniYlNLY2fJ/doVXImNBpnzH0PmmoL75TeoTN/
	WhG6N6jK7lFV+R7fX4uDERXQf/RJGLP8fkjLeDyHV8OjNwsHFZemYgV
X-Google-Smtp-Source: AGHT+IGQ/AlNfICvvkt7ASAAIexrGqodn0Sbi3YcqYgfSCwFa1R7Fox6A8C8UyOkyr1Tqf8nyrhWfjALWMTt1RKtaZQ=
X-Received: by 2002:ac8:7f13:0:b0:4b0:82e5:946b with SMTP id
 d75a77b69052e-4b119db8bfamr2805381cf.4.1755231387365; Thu, 14 Aug 2025
 21:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-2-sagis@google.com>
 <aJotMWGzChQq41oz@google.com>
In-Reply-To: <aJotMWGzChQq41oz@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 14 Aug 2025 23:16:16 -0500
X-Gm-Features: Ac12FXzup_S7jlhDOo8ZQRNApTopN0mRbrvYTez7vW_1j3Bwr78GTowA8j21oHs
Message-ID: <CAAhR5DGtLw=B1C3+aijcXWQFP+bgR95cCULdF9aE-+O-wXV+Gg@mail.gmail.com>
Subject: Re: [PATCH v8 01/30] KVM: selftests: Add function to allow one-to-one
 GVA to GPA mappings
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 12:49=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > One-to-one GVA to GPA mappings can be used in the guest to set up boot
> > sequences during which paging is enabled, hence requiring a transition
> > from using physical to virtual addresses in consecutive instructions.
>
> NAK, this is an extremely convoluted way for establishing mappings for ha=
rdcoded
> boot ranges.  Just use virt_map().  And if clobbering an existing mapping=
 is a
> concern, we should add an assert in virt_map() to verify the address is a=
vailable.

I'm able to replace this with virt_map() as you suggested. I'll drop
this patch in the next version.

