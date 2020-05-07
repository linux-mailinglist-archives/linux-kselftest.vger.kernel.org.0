Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE71C8596
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgEGJWc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 05:22:32 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46213 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEGJWc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 05:22:32 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49Hnzp4V3Rz1s15H;
        Thu,  7 May 2020 11:22:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49Hnzn4yNjz1qspk;
        Thu,  7 May 2020 11:22:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id HuTpiRr17Yjp; Thu,  7 May 2020 11:22:28 +0200 (CEST)
X-Auth-Info: My1rqRLQeRYwXTe8bTgqsiQduii7/8yaKxe1UwEuWa/9BFJuuxyboUhmQ8FG6wd2
Received: from igel.home (ppp-46-244-177-18.dynamic.mnet-online.de [46.244.177.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  7 May 2020 11:22:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 18A2D2C0D9B; Thu,  7 May 2020 11:22:28 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
X-Yow:  Where's my SOCIAL WORKER?
Date:   Thu, 07 May 2020 11:22:28 +0200
In-Reply-To: <158834028054.28357.398159034694277189.stgit@devnote2> (Masami
        Hiramatsu's message of "Fri, 1 May 2020 22:38:00 +0900")
Message-ID: <87eerwkskr.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mai 01 2020, Masami Hiramatsu wrote:

> Since the built-in echo has different behavior in POSIX shell
> (dash) and bash, we forcibly use /bin/echo -E (not interpret
> backslash escapes) by default.

How about using printf instead (at least where it matters)?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
