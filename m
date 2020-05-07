Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861CC1C9C6E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 22:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEGUdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 16:33:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:44363 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgEGUdE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 16:33:04 -0400
IronPort-SDR: VIVHXsFd5uqImcWOLkjQVHoOdpfYrLGRmbBZFpCD2H9N7A48JyXCJ1rtkBjdV5Pe4qmrMLvzDo
 kjldwaIqKFYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 13:32:50 -0700
IronPort-SDR: 2LFt945J76NOTSWp7WcmWtzjtsyY/Osp3JJ2Dzj+eZGSWEwQ/ykD5fyrpZq5nnMzO+NtjCLoQd
 Oerp+eOQH8Ig==
X-IronPort-AV: E=Sophos;i="5.73,365,1583222400"; 
   d="scan'208";a="260648194"
Received: from tzanussi-mobl4.amr.corp.intel.com (HELO [10.252.140.107]) ([10.252.140.107])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 13:32:48 -0700
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
 <158834028054.28357.398159034694277189.stgit@devnote2>
 <20200501101942.5c0da986@gandalf.local.home>
 <20200502120842.9d93352083fb854295150235@kernel.org>
 <20200507091207.5c3b1a92@gandalf.local.home>
 <20200508005028.a825d53373721a13d6cc80fc@kernel.org>
 <20200507132539.7e081980@gandalf.local.home>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <f575eead-c021-c830-b9d5-41437964db32@linux.intel.com>
Date:   Thu, 7 May 2020 15:32:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507132539.7e081980@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 5/7/2020 12:25 PM, Steven Rostedt wrote:
> On Fri, 8 May 2020 00:50:28 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>>>> Yes, I need Tom's review for this change. As far as I can test, this
>>>> fixes the test failure. If this isn't acceptable, we can use "alias echo=echo"
>>>> for this test case.
>>>>    
>>>
>>> I still don't see how changing "keys=common_pid" to "keys=ip" has anything
>>> to do with the echo patch. If that is a problem, it should be a different
>>> patch with explanation to why "keys=common_pid" is broken.
>>
>> This test case uses a trace_marker event to make a histogram with
>> the common_pid key, and it expects the "echo" command is built-in command
>> so that the pid is same while writing several events to trace_marker.
>> I changed it to "ip" which is always same if trace_marker interface is
>> used.
> 
> Can you explicitly state that in your change log? It wasn't obvious from
> what you meant with:
> 
> "This also fixes some test cases which expects built-in echo command."
> 

With that change,

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks,

Tom

> Thanks!
> 
> -- Steve
> 
