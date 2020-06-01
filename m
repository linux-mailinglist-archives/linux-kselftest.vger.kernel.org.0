Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8C1EAFD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFATyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 15:54:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:4097 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgFATyP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 15:54:15 -0400
IronPort-SDR: M8+Oo/IpFZTXFa1s+DfCxvLcNt5HOWvRM2mq3D5wrk0sxZIa4AMP34SGK/GFkJEJfYdydOkvRK
 nwFxqbCRL70g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 12:54:14 -0700
IronPort-SDR: 0ZwabU3a3BCQKjqDCCKDmfDjZ0xuKDlEFW6BGlaCn7Mh1iW9bU/pbrnt3VAML2YNm+okoPFz5T
 siGSxGigqImw==
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="293306446"
Received: from tzanussi-mobl4.amr.corp.intel.com (HELO [10.213.167.214]) ([10.213.167.214])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 12:54:14 -0700
Subject: Re: [PATCH 4/7] selftests/ftrace: Convert required interface checks
 into requires list
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <159102252279.31199.12855129586058455119.stgit@devnote2>
 <159102256204.31199.842249429317038334.stgit@devnote2>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <e23a0d5c-5e7e-13db-e9c1-2a093d3327be@linux.intel.com>
Date:   Mon, 1 Jun 2020 14:54:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <159102256204.31199.842249429317038334.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Masami,

On 6/1/2020 9:42 AM, Masami Hiramatsu wrote:
> Convert the required tracefs interface checking code with
> requires: list.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org
[ SNIP ]

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> index c80007aa9f86..59f876c80d45 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> @@ -1,17 +1,13 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0
>   # description: event trigger - test inter-event histogram trigger onchange action
> +# requires: synthetic_events

I think this should be 'set_event'

Thanks,

Tom
