Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7579B6CD172
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 07:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjC2FQ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 01:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2FQ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 01:16:28 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7601A171B;
        Tue, 28 Mar 2023 22:16:26 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32T5GBvQ009134;
        Wed, 29 Mar 2023 07:16:11 +0200
Date:   Wed, 29 Mar 2023 07:16:11 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: validate C99 compatibility
Message-ID: <ZCPJm/Nb2AGlJqXg@1wt.eu>
References: <20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Tue, Mar 28, 2023 at 09:07:35PM +0000, Thomas Weißschuh wrote:
> Most of the code was migrated to C99-conformant __asm__ statements
> before. It seems string.h was missed.
> 
> Fix string.h and also validate during build that nolibc stays within
> C99.

I'm all for improving portability, however I have a concern with building
the test case with -std=c99 which is that it might hide some c99-only
stuff that we'd introduce by accident in the nolibc's code, and I'd
rather not do that because it will mean changing build options for some
external programs using it if it happens. However I totally agree with
you that we need to make sure that there's no build issues with c99
compilers. Modern compilers are c99-compatible but generally come with
GNU extensions and I understand why you're interested in switching to
std=c99 in order to drop some of these like "asm". Should we have two
build targets, the default one and a c99 one ? Maybe. The build is so
small and quick that nobody will care, so we could definitely imagine
building the two versions. Maybe you have a better idea ?

Thanks,
Willy
