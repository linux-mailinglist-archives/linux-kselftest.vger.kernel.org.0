Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60246035AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 00:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJRWLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Oct 2022 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJRWLs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Oct 2022 18:11:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72908BC441;
        Tue, 18 Oct 2022 15:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5FA6160D;
        Tue, 18 Oct 2022 22:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1694DC433D6;
        Tue, 18 Oct 2022 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666131106;
        bh=qQp+2upQjHlhtFePatBvx7V5ITmvTLO6lleQcK1cJ9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dA7i1z/gISz3gic8Fe+/pKJCX09jnA3pkQYtw73CXjVocXQAnfI2/PFVYZesvyNV2
         1EYuMtRgc3HovCLt2bijvBDrTSvLxbelttluJpDIVolgM2C/waTy6zh2wR4XWl6aIo
         TcaKCZsEKoaQ10+bo9fhGqp+YJ4d/FpzUHrX3wXQ=
Date:   Tue, 18 Oct 2022 15:11:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v6] selftests/vm: enable running select groups of tests
Message-Id: <20221018151145.2997697f0251e3cb419e09ac@linux-foundation.org>
In-Reply-To: <20221018183021.1832032-1-jsavitz@redhat.com>
References: <20221018183021.1832032-1-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 18 Oct 2022 14:30:21 -0400 Joel Savitz <jsavitz@redhat.com> wrote:

>  tools/testing/selftests/vm/run_vmtests.sh | 212 +++++++++++++++-------

Lots of patches change this file so I can see I won't be liking this
patch :(

Can you please redo it against the mm-unstable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm and we'll see how
it goes?  Thanks.

