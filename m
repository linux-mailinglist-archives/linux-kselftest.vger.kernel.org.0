Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08489CC716
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2019 03:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfJEBGB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Oct 2019 21:06:01 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:3111 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJEBGB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Oct 2019 21:06:01 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5d97ec641ed-bc085; Sat, 05 Oct 2019 09:05:40 +0800 (CST)
X-RM-TRANSID: 2eec5d97ec641ed-bc085
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [10.0.0.249] (unknown[112.0.144.232])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d97ec619ac-e007b;
        Sat, 05 Oct 2019 09:05:40 +0800 (CST)
X-RM-TRANSID: 2ee65d97ec619ac-e007b
Content-Type: text/plain; charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 0/3] selftests: netfilter: introduce test cases for
 ipvs
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20191004114745.GB6803@dimstar.local.net>
Date:   Sat, 5 Oct 2019 09:05:37 +0800
Cc:     Julian Anastasov <ja@ssi.bg>, Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4C9C0C54-4CC6-49A4-A868-6F7604B1AB2B@cmss.chinamobile.com>
References: <1569939599-1872-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <alpine.LFD.2.21.1910012133330.3887@ja.home.ssi.bg>
 <20191002012726.GB9810@dimstar.local.net>
 <8E2E81F3-8385-4397-9A22-F513E507507D@cmss.chinamobile.com>
 <20191004114745.GB6803@dimstar.local.net>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On 2019年10月4日, at 下午7:47, Duncan Roe <duncan_roe@optusnet.com.au> wrote:
> 
> On Thu, Oct 03, 2019 at 10:41:06PM +0800, Haishuang Yan wrote:
>> 
>> 
>>> On 2019??10??2??, at ????9:27, Duncan Roe <duncan_roe@optusnet.com.au> wrote:
>>> 
>>> On Tue, Oct 01, 2019 at 09:34:13PM +0300, Julian Anastasov wrote:
>>>> 
>>>> 	Hello,
>>>> 
>>>> On Tue, 1 Oct 2019, Haishuang Yan wrote:
>>>> 
>>>>> This series patch include test cases for ipvs.
>>>>> 
>>>>> The test topology is who as below:
>>>>> +--------------------------------------------------------------+
>>>>> |                      |                                       |
>>>>> |         ns0          |         ns1                           |
>>>>> |      -----------     |     -----------    -----------        |
>>>>> |      | veth01  | --------- | veth10  |    | veth12  |        |
>>>>> |      -----------    peer   -----------    -----------        |
>>>>> |           |          |                        |              |
>>>>> |      -----------     |                        |              |
>>>>> |      |  br0    |     |-----------------  peer |--------------|
>>>>> |      -----------     |                        |              |
>>>>> |           |          |                        |              |
>>>>> |      ----------     peer   ----------      -----------       |
>>>>> |      |  veth02 | --------- |  veth20 |     | veth12  |       |
>>>>> |      ----------      |     ----------      -----------       |
>>>>> |                      |         ns2                           |
>>>>> |                      |                                       |
>>>>> +--------------------------------------------------------------+
>>>>> 
>>>>> Test results:
>>>>> # selftests: netfilter: ipvs.sh
>>>>> # Testing DR mode...
>>>>> # Testing NAT mode...
>>>>> # Testing Tunnel mode...
>>>>> # ipvs.sh: PASS
>>>>> ok 6 selftests: netfilter: ipvs.sh
>>>>> 
>>>>> Haishuang Yan (3):
>>>>> selftests: netfilter: add ipvs test script
>>>>> selftests: netfilter: add ipvs nat test case
>>>>> selftests: netfilter: add ipvs tunnel test case
>>>> 
>>>> Acked-by: Julian Anastasov <ja@ssi.bg>
>>>> 
>>>>> tools/testing/selftests/netfilter/Makefile |   2 +-
>>>>> tools/testing/selftests/netfilter/ipvs.sh  | 234 +++++++++++++++++++++++++++++
>>>>> 2 files changed, 235 insertions(+), 1 deletion(-)
>>>>> create mode 100755 tools/testing/selftests/netfilter/ipvs.sh
>>>> 
>>>> Regards
>>>> 
>>>> --
>>>> Julian Anastasov <ja@ssi.bg>
>>> 
>>> I still prefer #!/bin/sh in 1/3. You never know what's in someone's environment
>>> 
>>> Cheers ... Duncan.
>>> 
>> 
>> It??s also my preference too. "_"	
>> 
>> I have tested both #!/bin/bash and #!/bin/sh script, they all works properly.
> 
> Enter these 2 lines:
>> ip(){ return 0; }
>> export -f ip
> 
> Now try the #!/bin/bash script. If that now fails, try again with #!/bin/bash
> changed to #!/bin/bash -p
> 
> Any better now?
> 
> Cheers ... Duncan.
> 
It’s better now, thanks for your explanation.
In v3 commit I will use #!/bin/bash -p to prevent exporting function from environment variables.

