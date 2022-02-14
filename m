Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B34B5A0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 19:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiBNSkA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 13:40:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiBNSj7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 13:39:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEEF654B4;
        Mon, 14 Feb 2022 10:39:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE1260EAD;
        Mon, 14 Feb 2022 18:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB04C340E9;
        Mon, 14 Feb 2022 18:39:47 +0000 (UTC)
Date:   Mon, 14 Feb 2022 13:39:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <20220214133945.11119c2a@gandalf.local.home>
In-Reply-To: <8f034cd5-8495-de0e-6a3c-4d002e49cc51@linuxfoundation.org>
References: <20220214083657.165921-1-krzysztof.kozlowski@canonical.com>
        <Ygo6pqWmkTWJNNcR@linutronix.de>
        <8f034cd5-8495-de0e-6a3c-4d002e49cc51@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 14 Feb 2022 11:33:18 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Steve,
> 
> Would you like me to take this through linux-kselftest next for 5.18-rc1
> 
> I am guessing there is no urgency on this - of not I can take this in for
> rc5.

Hi Shuah,

Feel free to take it through your tree in any urgent level you like.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
