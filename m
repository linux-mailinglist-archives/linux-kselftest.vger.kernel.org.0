Return-Path: <linux-kselftest+bounces-39602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAEBB30812
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 23:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B309585B4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E543393DD1;
	Thu, 21 Aug 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoxKzoxX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5F21FF28
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810251; cv=none; b=kxWEW3U7d0NCmokJwwlzgq65qmSMqnO/YnRSeCk9HJMI1qqDhBrHn1g6FxLcU2bw4+J8FB8lt4NDjRfvduqUGnaeHUF8tjlT2raCaGzyCd4XrwaNDC9d5s8FUfs/5qAPtxIw1Bqy4+MyZBN74zIVaEffN1AQ69qelchMdgTwqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810251; c=relaxed/simple;
	bh=Ax/5M9fNgiaUpM60gNgoLr7S2/wLwZqWm5F2SXmLfG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVlRugupiDlqcCRqUtgX7rCMOY+cV5fFkxAiYz4U5n6NQncQoNvHFeNqEqvo6ZpgVC3D5DhGVhZzwPlOXqE92Rlb7DaygXH0HYtS52CLvoIeIv2LzI0CaTTfrnaXgv3MU9FSWxv0zmF3uabWb/t7ToU16M4RjlBRgKeIZk1Wcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoxKzoxX; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-89019119eeeso751427241.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810248; x=1756415048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiHzVX3qqPLSsGwTYsNg14BwO9f8YSWJkk7KXDdCW6Q=;
        b=QoxKzoxXs4JFDqpMIofYQsgGMSLkQxghekIWh1b/d8RwUYmcoBOL1wlZ3bKCSikNC7
         5rDMSQJDTsbUZjTxs62THojZGcKY1j4zn8u8cJLCtDOltClY9zKaEBPBWdVT/F+O1qNs
         wo8C0LNTG0gKmd8471cSCATxj9AX7LHCRZP7qTKaJgEv0jI3izQeVncFuwMj39U1EC5l
         AvZMUty0OEk/a7Cu3/8a0MlsjeVJz0eJ/6pFQlVbUCNOQvlmCxsF40tOMtdR9k6FZwHC
         HT4CWf1WdeKJh7r8+4bDJroO1bH/Td8TPMnAlugfMj/xko4iU0NETDN0cJtlMALWTH3U
         1X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810248; x=1756415048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiHzVX3qqPLSsGwTYsNg14BwO9f8YSWJkk7KXDdCW6Q=;
        b=rSUUrdVMGwfjol92neImSkYniR+43FGlT4SOxwyZ0m/FNilwjNV02Zer6d8xgckzOu
         G9QIKuLydv69ekzXJvM24GlP7DY5RKHSqTeMHQHCbqKZZyjymk4gB5QbegDbZvp6254j
         +CBywgyRx0BEeaWM0cRLpyAZlq0SNyDbinMbsjDKbFl6QQQLytZPG1oDvflTM0VVtFny
         60wfvtmyYmtnyG2LlrPWh7BvZbz9PWzCuIyrFSjn463Dd8/0Kr1AI4wAqFwurmBAQsaQ
         TfDhSKCuLHHMqXQfbZH9akFgOo47Alq4HY512TKaFc7SHcLNRVhCbvfCXnJhdW94I+AA
         97sg==
X-Forwarded-Encrypted: i=1; AJvYcCU1GizyP8RbmjEyNVzV6YU9PUpstnKOsCybEAcp7fQz/qwVoE2pmcnqGQA/yotU+hXB0ENVCBGD11ai/4qUYWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcILVyeDXunTi51A5WQ0TMDumESOse4n7Cn4r68mbcigquqsN
	CQgzcggEzMtRvZpePaDXAvVu7qEXT0N+E8U+/4iTA3xoNjyM54/pukpesbgYiFEmcOVH8AfBME8
	gaJXKbIu2zA0OqlSzm5R5LO/1B0c+k6LJlQ1+6uTn
X-Gm-Gg: ASbGnctkItgHeEIDRndfn84AwYJmfSLr4OdbBN7dt3qA6DjEf0YW5SZqH1kDIgf+oLA
	ZyV+0TViCfurnaN85lRWm/B5v1qfUqRHeXNKYSgAdyx6F32mloFBchQ9bOOVk2XQYUgOfIVk/AU
	VqJuXpJg3GVam/NeQkBzdpBMUgcbomCzJkScgTzVuibs4siXB9pga/Y+4YLK3JxFSSGfBh1Gma1
	fDcYOyixVqglTwt866cbrgAZdlonGU8QWGn6wftBiCCAQUOvjq5YozQ
X-Google-Smtp-Source: AGHT+IH8BmhwAV5TMq5jtuv5CcD52sEM4hDAtFzPHkyrC5f4RE9vRJicCBjwB0j/euUZjYyXAYbjQQDm0mf50m9A4Hw=
X-Received: by 2002:a05:6102:3714:b0:4fa:d2c:4ff with SMTP id
 ada2fe7eead31-51d0f2ea55dmr219355137.27.1755810248226; Thu, 21 Aug 2025
 14:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <CALzav=dVYqS8oQNbygVjgA69EQMBBP4CyzydyUoAjnN2mb_yUQ@mail.gmail.com>
 <20250728102737.5b51e9da.alex.williamson@redhat.com> <20250729222635.GU36037@nvidia.com>
 <CALzav=d0vPMw26f-vzCJnjRFL+Uc6sObihqJ0jnJRpi-SxtSSw@mail.gmail.com>
 <CALzav=fdT+NJDO+jWyty+tKqxqum4RVkHZmUocz4MDQkPgG4Bg@mail.gmail.com>
 <20250818133721.32b660e3.alex.williamson@redhat.com> <CALzav=eOz+Gf8XawvaSSBHj=8gQg3O9T9dJcN6q4eqh7_MEPDw@mail.gmail.com>
 <20250821141048.6e16e546.alex.williamson@redhat.com>
In-Reply-To: <20250821141048.6e16e546.alex.williamson@redhat.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 21 Aug 2025 14:03:39 -0700
X-Gm-Features: Ac12FXx-07ysjjhbXcW1d6QGdWIOYK7REtcOvofZDmLrqHjrbC9iI7jgWdySeG8
Message-ID: <CALzav=f=tg_oz1pEOKFiswBKnTCbrPOJR-DgAK_--jmSkxbCWw@mail.gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 1:10=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> I think we have all the required acks now and reviews just suggest some
> minor patch shuffling, right?.  You were also going to switch from
> reviewer to maintainer of the selftests in MAINTAINERS ;)
>
> Are you planning to collect those acks, add the minor changes, drop the
> trailing KVM changes to come in through the existing kvm selftests and
> repost?
>
> With KVM Forum coming up, I'd like to try to get this squared away and
> into the vfio next branch by next week.  Thanks,

Heh, I was just going to send a similar email to you :)

That plan sounds good to me. I will prep a new series with those
changes and send it out at the beginning of next week (fingers
crossed).

Thanks.

