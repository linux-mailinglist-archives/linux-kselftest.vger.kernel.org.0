Return-Path: <linux-kselftest+bounces-1343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7578083A0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B0F1F22556
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB028E02;
	Thu,  7 Dec 2023 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D556YxEZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F7210B
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 00:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701939417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjb24Mm+TO5MXS0Md6L/Y5JPRs7VNdcjPv1AKibj1Rg=;
	b=D556YxEZn+hzjcDwOYTXSDgIM8g8rEYt4cDRkwqcKTahKSpqgkg1A61f7q417Sn4cm6K7Y
	q21Fvq7BQGXDRzrXfXybmAaAGqYGrr+ssm/TCSNvYpEbv9Dltyjh2kDXbqXAP1n9U7F0QA
	Wglcc3swWs7uYVCIr9FakhUWO5G+dTU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-OIwIs02gPn-tYoetZl2lnA-1; Thu, 07 Dec 2023 03:56:55 -0500
X-MC-Unique: OIwIs02gPn-tYoetZl2lnA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1c915eae11so190350666b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 00:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701939413; x=1702544213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjb24Mm+TO5MXS0Md6L/Y5JPRs7VNdcjPv1AKibj1Rg=;
        b=pBlpmoaqSle9YJXjD6mbZVTNjAzGB5YL+yYzOr3PATDrU0uJzl0j8PEJ2Y+nUcm5Hk
         h9p3EuAlYcxkM2188jX62WakjENgCbRCwCtJkPzcqMdmcNnAfHCn0BFBAYnrb67j+k+W
         5hpI2x2OmHzK67y93qEbQNIRz/lmjamxWSK5DYOYKpPiNowX7GWDgUXe5sjACf4ZWGyq
         6DxBe5pKDw9hoAssXR8HGWJCrWO04mQfVlOmghnoG+GPE8pIeSY+HHkjDC4L3Rp8CT6H
         2pS1P/NO30E+jT5vUkegUYWueBEvi39PUQMJ18D/cyv5X+6TM6M7t8dWqzIMxQMRs6Sr
         B8xw==
X-Gm-Message-State: AOJu0Yz3eOJXrr+J+jJdEdZYjBF2okgiuKHOzCIyuijf/9Yq54iurZHm
	crzWuZGiPmzjRSgp+2knw6MWk5R2bK409uk9/V/ofXvGkD3LXtT2cvzqwyuWQbeMO/H9tZTpxPz
	J4WlBCcFAzmW0y2nHVO4FDu+h6Lnqc+sKqr/itx9N7RN3S8/wIugc
X-Received: by 2002:a17:906:51d9:b0:a1d:5483:d152 with SMTP id v25-20020a17090651d900b00a1d5483d152mr3231943ejk.68.1701939413296;
        Thu, 07 Dec 2023 00:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKIhhZEKnvU9mv82qAnevu5zZsbtr1NFNSThdCDWarWHBT2exXLQczsV9NjkPIznTWYjB/bhUNP2uGJlaDSUg=
X-Received: by 2002:a17:906:51d9:b0:a1d:5483:d152 with SMTP id
 v25-20020a17090651d900b00a1d5483d152mr3231933ejk.68.1701939413001; Thu, 07
 Dec 2023 00:56:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org> <170193920703.229356.5910722658341910962.b4-ty@kernel.org>
In-Reply-To: <170193920703.229356.5910722658341910962.b4-ty@kernel.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 7 Dec 2023 09:56:40 +0100
Message-ID: <CAO-hwJ+f-qLtcY=A+yVQZA5M4unO6T7ogGK_mvqwAnsViM_+1Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] selftests/hid: tablets fixes
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 9:53=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> On Wed, 06 Dec 2023 11:45:51 +0100, Benjamin Tissoires wrote:
> > the main trigger of this series was the XP-Pen issue[0].
> > Basically, the tablets tests were good-ish but couldn't
> > handle that tablet both in terms of emulation or in terms
> > of detection of issues.
> >
> > So rework the tablets test a bit to be able to include the
> > XP-Pen patch later, once I have a kernel fix for it (right
> > now I only have a HID-BPF fix, meaning that the test will
> > fail if I include them).
> >
> > [...]
>
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (f=
or-5.8/selftests), thanks!

of course, it's for-6.8/selftests, not 5.8 :)

Cheers,
Benjamin

>
> [01/15] selftests/hid: vmtest.sh: update vm2c and container
>         https://git.kernel.org/hid/hid/c/887f8094b335
> [02/15] selftests/hid: vmtest.sh: allow finer control on the build steps
>         https://git.kernel.org/hid/hid/c/46bc0277c250
> [03/15] selftests/hid: base: allow for multiple skip_if_uhdev
>         https://git.kernel.org/hid/hid/c/110292a77f7c
> [04/15] selftests/hid: tablets: remove unused class
>         https://git.kernel.org/hid/hid/c/b5edacf79c8e
> [05/15] selftests/hid: tablets: move the transitions to PenState
>         https://git.kernel.org/hid/hid/c/d52f52069fed
> [06/15] selftests/hid: tablets: move move_to function to PenDigitizer
>         https://git.kernel.org/hid/hid/c/881ccc36b426
> [07/15] selftests/hid: tablets: do not set invert when the eraser is used
>         https://git.kernel.org/hid/hid/c/d8d7aa2266a7
> [08/15] selftests/hid: tablets: set initial data for tilt/twist
>         https://git.kernel.org/hid/hid/c/e08e493ff961
> [09/15] selftests/hid: tablets: define the elements of PenState
>         https://git.kernel.org/hid/hid/c/83912f83fabc
> [10/15] selftests/hid: tablets: add variants of states with buttons
>         https://git.kernel.org/hid/hid/c/74452d6329be
> [11/15] selftests/hid: tablets: convert the primary button tests
>         https://git.kernel.org/hid/hid/c/1f01537ef17e
> [12/15] selftests/hid: tablets: add a secondary barrel switch test
>         https://git.kernel.org/hid/hid/c/76df1f72fb25
> [13/15] selftests/hid: tablets: be stricter for some transitions
>         https://git.kernel.org/hid/hid/c/ab9b82909e9b
> [14/15] selftests/hid: fix mypy complains
>         https://git.kernel.org/hid/hid/c/ed5bc56cedca
> [15/15] selftests/hid: fix ruff linter complains
>         https://git.kernel.org/hid/hid/c/f556aa957df8
>
> Cheers,
> --
> Benjamin Tissoires <bentiss@kernel.org>
>


