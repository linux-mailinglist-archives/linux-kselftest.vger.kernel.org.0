Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609BC252A09
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Aug 2020 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgHZJaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Aug 2020 05:30:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgHZJaR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Aug 2020 05:30:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC6AFAD39;
        Wed, 26 Aug 2020 09:30:46 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 29/29] tools: Avoid comma separated statements
Date:   Wed, 26 Aug 2020 11:30:14 +0200
Message-ID: <6011591.XMClsHuqKX@c100>
In-Reply-To: <52b68acfeb441b483de188f7e100600291f8c3ec.1598331149.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com> <52b68acfeb441b483de188f7e100600291f8c3ec.1598331149.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

getting rid of lines with multiple instructions, separated by comma is
certainly a good idea.
One nit pick, though:

Am Dienstag, 25. August 2020, 06:56:26 CEST schrieb Joe Perches:
> Use semicolons and braces.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  tools/lib/subcmd/help.c                    |  10 +-
>  tools/power/cpupower/utils/cpufreq-set.c   |  14 +-
>  tools/testing/selftests/vm/gup_benchmark.c |  18 +-
>  tools/testing/selftests/vm/userfaultfd.c   | 296 +++++++++++++--------
>  4 files changed, 210 insertions(+), 128 deletions(-)
> 
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index 2859f107abc8..bf02d62a3b2b 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -65,12 +65,14 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames
> *excludes) ci = cj = ei = 0;
>  	while (ci < cmds->cnt && ei < excludes->cnt) {
>  		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
> -		if (cmp < 0)
> +		if (cmp < 0) {
>  			cmds->names[cj++] = cmds->names[ci++];
> -		else if (cmp == 0)
> -			ci++, ei++;
> -		else if (cmp > 0)
> +		} else if (cmp == 0) {
> +			ci++;
>  			ei++;
> +		} else if (cmp > 0) {
> +			ei++;
> +		}
>  	}

I can remember patches being rejected with one line statements in a condition,
surounded by braces.
I just read up Documentation/process/coding-style.rst, to be sure this still is up-to-date.
It's not a must, but line 180 says:
"Do not unnecessarily use braces where a single statement will do."

So if this is about coding style cleanup, IMO you should remove braces from single line
statements.

I haven't reviewed every line, but I expect you only split up comma separated instructions
into separate lines and added braces?

Afaik there isn't a specific tag, but having:
cleanup only: No functional change

in the changelog would be nice for people looking for fixes to backport.


Otherwise, I think this is a worthful cleanup.

     Thomas


