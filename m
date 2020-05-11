Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E51CD980
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgEKMT1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 08:19:27 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47408 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgEKMT1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 08:19:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49LKk22n2Tz1qs4F;
        Mon, 11 May 2020 14:19:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49LKk203qYz1qspZ;
        Mon, 11 May 2020 14:19:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 8cShAs1Muh7y; Mon, 11 May 2020 14:19:21 +0200 (CEST)
X-Auth-Info: dhtQoNAEhEUEkKcjAaW5OFOS1FDoApCzJeoQrMso3MQAbl1rgVTOfvsvU8Y9GhxT
Received: from igel.home (ppp-46-244-172-93.dynamic.mnet-online.de [46.244.172.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 11 May 2020 14:19:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 7A72E2C0C52; Mon, 11 May 2020 14:19:20 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH] selftests/ftrace: Use /bin/echo for backslash included
 command
References: <20200511182752.c83f3454bcb3e205cf2bda4a@kernel.org>
        <158919846272.12476.10277703957544382089.stgit@devnote2>
X-Yow:  I will establish the first SHOPPING MALL in NUTLEY, New Jersey...
Date:   Mon, 11 May 2020 14:19:20 +0200
In-Reply-To: <158919846272.12476.10277703957544382089.stgit@devnote2> (Masami
        Hiramatsu's message of "Mon, 11 May 2020 21:01:02 +0900")
Message-ID: <87imh21x6f.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mai 11 2020, Masami Hiramatsu wrote:

> To fix this issue, we explicitly use /bin/echo -E (not interpret
> backslash escapes) if the command string can include backslash.

Please use printf instead.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
