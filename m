Return-Path: <linux-kselftest+bounces-19674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA7399D844
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 22:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12018282E54
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 20:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B401D12FE;
	Mon, 14 Oct 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oa/KnPTE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFAB1D12EC
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937974; cv=none; b=gx7fnISwr2pw/7Gz60WlMwIWOY/xeoo/hzHJGTFk30faJS/HUjMcVAubkVUWGGnTFBBiZL1HwnDAaVtyMC8gOLAfqJim0KuehmiYINtbd8O62qkLTk37cY+I+CwEIsDsD0h+/twIIhPginpTaNTNb4wMHALhyNloGQXmwEu2ob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937974; c=relaxed/simple;
	bh=I8SPlUf63OyKm61QgjAtJIGxNR068+dmheUm2cKrywc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OdbDlUZslsyg3Z9zxWqrnnxAM+WHqAkbisa37Scr90ol3IWgSHVuN5jwjOwXqYuXtewIqvDxIL14NrLDk2mDbVXx1GFOvcSjBZ3Z6wDSPO9SIyyI/BtFB8PNeE5ssABB9SgYmeqFuFQ2EZAQCf37v0OX8GToldw37KLZ7HJ0bUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oa/KnPTE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728937971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rICH7gY+J+cXT0uk6GhkMD4lYgCJxm+vEVmSW1XPEU8=;
	b=Oa/KnPTEP7/Hs4hjOwsEV6AOgbM3hm9jsAn0xuakpIWqtKL+DVLTCmPAnnYsw9kuewLYqY
	lAKKWhw4hJw2HHZv4M+nRmRPGrjOGecsH5qXTwju66DOhdccdFh9eknMNuDgbVwsO3a9cx
	3weuPiFV+OSOjTJ4AqTH45jjDjYuRyE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-e7tX8ghRO0uWmTgOay0VMw-1; Mon, 14 Oct 2024 16:32:49 -0400
X-MC-Unique: e7tX8ghRO0uWmTgOay0VMw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6e38562155bso14564407b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 13:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937969; x=1729542769;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rICH7gY+J+cXT0uk6GhkMD4lYgCJxm+vEVmSW1XPEU8=;
        b=RUh7VN3EHV30T3jhy0eJiKOAtv4D5bGEwjjja1BFDbTfnT6taznrTAKeh1IurRiAo4
         1NnPhup1+Y1wtygOV5imBoez7iAxQZbrAWfvmujoMrULURwYZLSzjrj5Rq71CB7DbDiV
         I32lkxQuigo91/2zhlgyX+q1EOZFTdg8hmL/PL8+cmOPFed0WL7JuNPxRPedgZbrS+EQ
         pNwoJKC4gmCZViTwldpmAupBYn810WXBX+cm3uVHqyexKV4GrQnq/rPLEwN9vj9Hx+74
         C3jTjYzSLZTXNKum8Q6A0P2lRCyOP7AAQ7WJoz33OAT8aEIxBSbn4vP0fqERCVP7Iikc
         IJpw==
X-Forwarded-Encrypted: i=1; AJvYcCX6hDmLeK0TSxkOk4R6BI2T3YZekLeMmXURyYvzqcS/A/rHYvUgO/17xuLMoIPrLqtjm0k5q5ZbuzEWA9Dxi7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXNiKnoI976kW/OnGytbjIl+mPoxKy14Ka4ApUwlj8QbZKVbp
	9EjGtUJdue3WlCQWUnVaXBLBNQUMCWT1uVHnsiWpw1bYw5rr3FY6n4Hdnlxnzm6Y/mG+5qNITgY
	TeP60Fjhl053KvwIR95HCjwFiRRmMbh4iHGO+jHPpbRszYRg4Q98Jg01PAf9b5GEN+/xPX1gWhB
	vzcXlt1e9MNZpvuvMh4fT3Dj65QAqjpYvzkiOSDCpl
X-Received: by 2002:a05:690c:c0a:b0:6e3:1f02:407b with SMTP id 00721157ae682-6e3479b952emr104674537b3.11.1728937969277;
        Mon, 14 Oct 2024 13:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx06yBHTeiKFZ9L5RrQ9VF0zIcHvf14RARbncPs3uTJzudMbdRLRPqc1mw21CvffdCDexOqb30DJWFeQ7knCg=
X-Received: by 2002:a05:690c:c0a:b0:6e3:1f02:407b with SMTP id
 00721157ae682-6e3479b952emr104674407b3.11.1728937968878; Mon, 14 Oct 2024
 13:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Donald Zickus <dzickus@redhat.com>
Date: Mon, 14 Oct 2024 16:32:37 -0400
Message-ID: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
Subject: [RFC] Test catalog template
To: workflows@vger.kernel.org, automated-testing@lists.yoctoproject.org, 
	linux-kselftest@vger.kernel.org, kernelci <kernelci@lists.linux.dev>
Cc: Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, laura.nao@collabora.com
Content-Type: text/plain; charset="UTF-8"

Hi,

At Linux Plumbers, a few dozen of us gathered together to discuss how
to expose what tests subsystem maintainers would like to run for every
patch submitted or when CI runs tests.  We agreed on a mock up of a
yaml template to start gathering info.  The yaml file could be
temporarily stored on kernelci.org until a more permanent home could
be found.  Attached is a template to start the conversation.

Longer story.

The current problem is CI systems are not unanimous about what tests
they run on submitted patches or git branches.  This makes it
difficult to figure out why a test failed or how to reproduce.
Further, it isn't always clear what tests a normal contributor should
run before posting patches.

It has been long communicated that the tests LTP, xfstest and/or
kselftests should be the tests  to run.  However, not all maintainers
use those tests for their subsystems.  I am hoping to either capture
those tests or find ways to convince them to add their tests to the
preferred locations.

The goal is for a given subsystem (defined in MAINTAINERS), define a
set of tests that should be run for any contributions to that
subsystem.  The hope is the collective CI results can be triaged
collectively (because they are related) and even have the numerous
flakes waived collectively  (same reason) improving the ability to
find and debug new test failures.  Because the tests and process are
known, having a human help debug any failures becomes easier.

The plan is to put together a minimal yaml template that gets us going
(even if it is not optimized yet) and aim for about a dozen or so
subsystems.  At that point we should have enough feedback to promote
this more seriously and talk optimizations.

Feedback encouraged.

Cheers,
Don

---
# List of tests by subsystem
#
# Tests should adhere to KTAP definitions for results
#
# Description of section entries
#
#  maintainer:    test maintainer - name <email>
#  list:                mailing list for discussion
#  version:         stable version of the test
#  dependency: necessary distro package for testing
#  test:
#    path:            internal git path or url to fetch from
#    cmd:            command to run; ability to run locally
#    param:         additional param necessary to run test
#  hardware:      hardware necessary for validation
#
# Subsystems (alphabetical)

KUNIT TEST:
  maintainer:
    - name: name1
      email: email1
    - name: name2
      email: email2
  list:
  version:
  dependency:
    - dep1
    - dep2
  test:
    - path: tools/testing/kunit
      cmd:
      param:
    - path:
      cmd:
      param:
  hardware: none


