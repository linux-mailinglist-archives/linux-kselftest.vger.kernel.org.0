Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3547E87D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Dec 2021 20:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350158AbhLWTuA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 14:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbhLWTuA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 14:50:00 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D688C061401;
        Thu, 23 Dec 2021 11:50:00 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF3636A2;
        Thu, 23 Dec 2021 19:49:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF3636A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640289000; bh=bnTBnhSPcCEoQzB7ak0rrVGPU20a1uEj6Ao1T/CrHLw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DSpB/jSStRCVfstwhdKNMhSbMhh+kRoB4lKXwnf4Bg/50m6hdqvfLTExwn0v2ra8e
         0t/Jr/QNQglZ2zJXcHqmYRzCT8aglDyqrsJkVqc/3Zxr0eGLuv6t7+O1ey77gZ+wx2
         xkaIkH95cSOONNyJ/4qxAl8hDpXKqLKv1D2uzXwU9k/mMalVPwURI9sXw1CR5pQUFt
         plnJmkuPN/SJFqdqAuIVj2IN/foNdr5TG0T53ZZAz2h2Kv0WLmJag03yHAITUZUEHf
         tCuEo7mNDKs51EFJLnn/p3b8Q7jB2QkPXgFEw+rEC3mM1aAF1uy1SSLQz7UUt7UOl+
         jh8+054jVzPOg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Harinder Singh <sharinder@google.com>, davidgow@google.com,
        brendanhiggins@google.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, elver@google.com,
        Harinder Singh <sharinder@google.com>
Subject: Re: [PATCH v6 0/7] Documentation: KUnit: Rework KUnit documentation
In-Reply-To: <20211217044911.798817-1-sharinder@google.com>
References: <20211217044911.798817-1-sharinder@google.com>
Date:   Thu, 23 Dec 2021 12:49:59 -0700
Message-ID: <87v8zfdrtk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Harinder Singh <sharinder@google.com> writes:

> The KUnit documentation was not very organized. There was little
> information related to KUnit architecture and the importance of unit
> testing.
>
> Add some new pages, expand and reorganize the existing documentation.
> Reword pages to make information and style more consistent.

Series applied, thanks.

jon
