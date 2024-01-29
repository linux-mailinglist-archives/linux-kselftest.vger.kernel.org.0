Return-Path: <linux-kselftest+bounces-3691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F058409A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 16:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D35287868
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFC153BD9;
	Mon, 29 Jan 2024 15:18:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCAD153BC1;
	Mon, 29 Jan 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541496; cv=none; b=Gg9kVicy71HEIjl5yT45gk64Z71a+YCns4I9NIpdIlCnbUqfWg/lalYFE1kHQN1S2QcrQEsUIOPxmD1Rd7Q9devjH32dHj+HdN5lsEn2yyZOZsTy6aHMy9bev+8hyUXJIz+3vI3ZBVzKtfcfMt0YdcD1ajrXj1slSqoBXSEhJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541496; c=relaxed/simple;
	bh=mbj/GubrUM5ol2t9pipY347bjtlgBP1tVcH6RRQE3wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We5HOxRbh3NqqwOt2IVEO1qJDfa1veYVXGoI2olFQ4HCvhNltsDUYxl+460aa2ZGEqBPemQmVbFm8gndmqfIfnChOv+6/0yr8MekJNlbq/xCL0/fp35W8yoWA+hoF8fB+vySCll56//+cGjJ8w3aWUQDh6/Aqy+wgbqkq9iDmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2148d3d7334so62345fac.1;
        Mon, 29 Jan 2024 07:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541494; x=1707146294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbj/GubrUM5ol2t9pipY347bjtlgBP1tVcH6RRQE3wc=;
        b=N3r+DzYqf0KluXXRVYrFWxGv8GEArMqPYH6GK1YDw49OIvFbTagOuKI4h4i+L+okh7
         BP2zrVCEZEe/LpWVn1LxxqGd5haYDvl+rjjKjOCDBWTax4+qvXhX5meJpNHGklTaJp/p
         dyKvRnbHDUMwCrlmH/WjjJy3wIaD1uc4TB6hl0t8zko7zpbYusLJTva0+bog8I1JDGsW
         TwZQ9MMbDZ2KJc4DQimHEbZzSct4qsMv7NJ1U+YO3L/StyVrXEq2wIvCHMINCqZRWkDT
         +JL/MJVP0v4LM8yiCs2exAhNJN1M6Bv7rYorZ1ZQ/EG5DsawIJqO74ze4+mzvbfFQheB
         1K9w==
X-Gm-Message-State: AOJu0YzQIYjIJR9JMqJyW0vLP4CX4/+DVXy0KuRypVkyEXzsiQ2kNlB7
	F0dhUuoEi/+ni2tlJCVEUfkTKCpcMMVHyJg2Dr5CyqItpLRkBq7frc8mNmJuDQX1i83IPcIozV4
	NnVVqQveXbfA4Py1XqJk3n4g2wJk=
X-Google-Smtp-Source: AGHT+IF4EQ5CmMMdAEPRwd5BhiwlO/wr9Z43o2bbICKJbvBtQl8/eSjsNtzW7mM8AUn1ZTuLaLkOrdQrq9+8mpchb8c=
X-Received: by 2002:a05:6870:a927:b0:204:5ad3:e6ec with SMTP id
 eq39-20020a056870a92700b002045ad3e6ecmr7295673oab.4.1706541493935; Mon, 29
 Jan 2024 07:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119090502.3869695-1-li.meng@amd.com>
In-Reply-To: <20240119090502.3869695-1-li.meng@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 16:18:02 +0100
Message-ID: <CAJZ5v0gzKdjZJBypEw1+czGN-SHbx0s0-h=Lq96+MDVAO11PYQ@mail.gmail.com>
Subject: Re: [PATCH V14 0/7] amd-pstate preferred core
To: Meng Li <li.meng@amd.com>, Borislav Petkov <bpetkov@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui <ray.huang@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>, 
	Deepak Sharma <deepak.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, 
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 10:05=E2=80=AFAM Meng Li <li.meng@amd.com> wrote:
>
> Hi all:
>
> The core frequency is subjected to the process variation in semiconductor=
s.
> Not all cores are able to reach the maximum frequency respecting the
> infrastructure limits. Consequently, AMD has redefined the concept of
> maximum frequency of a part. This means that a fraction of cores can reac=
h
> maximum frequency. To find the best process scheduling policy for a given
> scenario, OS needs to know the core ordering informed by the platform thr=
ough
> highest performance capability register of the CPPC interface.
>
> Earlier implementations of amd-pstate preferred core only support a stati=
c
> core ranking and targeted performance. Now it has the ability to dynamica=
lly
> change the preferred core based on the workload and platform conditions a=
nd
> accounting for thermals and aging.
>
> Amd-pstate driver utilizes the functions and data structures provided by
> the ITMT architecture to enable the scheduler to favor scheduling on core=
s
> which can be get a higher frequency with lower voltage.
> We call it amd-pstate preferred core.
>
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> Amd-pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
>
> Amd-pstate driver will provide an initial core ordering at boot time.
> It relies on the CPPC interface to communicate the core ranking to the
> operating system and scheduler to make sure that OS is choosing the cores
> with highest performance firstly for scheduling the process. When amd-pst=
ate
> driver receives a message with the highest performance change, it will
> update the core ranking.

Hi Boris,

You've had comments on the previous version of this.

Have they all been addressed?

