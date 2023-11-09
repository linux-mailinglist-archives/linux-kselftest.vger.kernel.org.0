Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B298C7E6EBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjKIQcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 11:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjKIQcJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 11:32:09 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9088135A5;
        Thu,  9 Nov 2023 08:32:06 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3A9GVg4S027141;
        Thu, 9 Nov 2023 17:31:42 +0100
Date:   Thu, 9 Nov 2023 17:31:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: run-user improvements
Message-ID: <ZU0Jbg6JT2Tn2n3M@1wt.eu>
References: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
 <zvzacp6mqu6xhg4dx56kh67ucl6wmtnydm677tull2bx74i2zz@ebj4juspkjfw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zvzacp6mqu6xhg4dx56kh67ucl6wmtnydm677tull2bx74i2zz@ebj4juspkjfw>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 09, 2023 at 11:28:41AM -0500, Konstantin Ryabitsev wrote:
> On Wed, Sep 15, 2077 at 02:13:51AM +0200, Thomas Weißschuh wrote:
>         ^^^^^^^^^^^^
> 
> I'm curious how this happened, especially since this was sent with b4.

We didn't want to tell you, but you slept 54 years Konstantin, the
current kernel is version 41.8 ;-)

Willy
