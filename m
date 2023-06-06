Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0CA724DAF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjFFUKh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 16:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjFFUKg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 16:10:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD06E10F2;
        Tue,  6 Jun 2023 13:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq3BjW87gkgFm/UlKj9iKWsMONqypfyccFk40Ku8lDTD3qhnf9BfYF7SjFpQgmbG8I16trM/spdwbpk9MJWHrcfBWELz04dLZ2CDyGSSKABnEPEd9l4DYqmAs91k+3w2nwwwbBEPshCaF2PEfg0rHdmv/shnRR8/vUUI9MJRwCovi+cwCN4w14SC5XXtRaKpvz93uL6W1FO10LRqgy4Vrlo2DseWO7cnphZ6XGli3hJkR11I5tRpLrLK9Rn0Yj18VZcinNqG0QJRmTzB0EML5aIa24o1IZDEDxTrxhrfmlY39n6BGBDz3w7muU1jcGyAY03hSCKvUcRMm//7KwOakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M33INbL8BorcBGS83Xa643i6qxn6gxPsDQ6TuvIFZqY=;
 b=Gc9JO4maUSBH8g2lf6pdwq1Lu5NQxjZXtC1R8hqDFtjE8IPq90OKsRLaapLZlaA290G719xHPpqOlWX+47op+wfQegiO9oZS9aRE8VTeVq8XJpafSMo9+xhBGQBrVBPPBNhetRME/jGp/kKlIcDMquEffSgGZpT/Yxt5kBVbpNaOZLkKQ4gMEgYCfFyozNVXdgYHQupe86DCZVFlCEJuS7r3C6E5oqXnEJsXQgFeRIgZlgOHVr0qoCNbK0H8T8FBOOIYr+q+4YiDGbok4POOrzNAQCk4W03rkAUe0kojnW20QEk34Y/DZN1m+1ZDiw5R4jg2w30aACmQ9OK2LwWd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M33INbL8BorcBGS83Xa643i6qxn6gxPsDQ6TuvIFZqY=;
 b=qIi3a/s3AyHXfvl6eVAAZHJ5sGQLkQ/yo65k/cNmsqhPxzkj6fOUGN+MK7So8EoZI0qf/OOKYpqWbMn8BoAG8R0/vjrW2fRLaf1cP1L754RJyyQrLqTNEvk8lAwvn05AlHA5JELR9VCkhVveRlqDp2QuUU0e65bx3v9+3jUCdaTNZ2HJ1mKa0Z9P3+MftHQNRuFPlhlaCTqPD6okAQnZ0LeKG9lc7hv/nYjYZ14lJlgBaKmamghuyrftr72rJkiBa+dnm0bTWtzyqURC88pKnS+KGxdqOFtacO6xc6HvKn3wYY49mqmDBDk3W6uPlD3V++M+1kOfpsp8Ul7xrLOIXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 20:10:30 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 20:10:30 +0000
Content-Type: multipart/mixed; boundary="------------jP6YgWTrDDApUlrGwhMuU180"
Message-ID: <14573e7e-f2ad-ff34-dfbd-3efdebee51ed@nvidia.com>
Date:   Tue, 6 Jun 2023 13:10:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <8e208e0f-699c-2c34-d66e-bf6d488a7a1e@collabora.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8e208e0f-699c-2c34-d66e-bf6d488a7a1e@collabora.com>
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cc9787-2aa0-46a2-4345-08db66ca13aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCOcreOr+su31Uffg25ipDvuzYv9NgfhbqpS9hnrRITxVquF4+4iCKOjZmn4QvHst/wlY+NWWNP3vytxb0L5QbFqL1tKmLSV92L2hzbhElevE6FxZqOEwqkiEzFk29icSApFsRPpFauvQMXZ0jiy1jbv20GcT7TfCJbi5voKW283UdwbuQGc+QwcSIFd+b5rIu8vMhkEc+haoFJKnxncmARvc5uSooxB8wzjSVPV4sOvXzJiC6mXr3FeSxdhWfRFuPhV073Ln8UAVLDHdjBweC5T9N3wfEoSosqx78OFUgPnApv86H8WepKddhGe9sDf8FI+gTRd8VuGjUm+EaFalF+GRupEfi0WaAtm2TCanE7DQqGMYBzk2rmv70aZRww8hRA9/wyDWNtF5CetxucvZLlADu5268ifDkRxqbNp/n0sXNeRca46oIrJHllSlfTfnfFQ/BudvuqZf5TJ+49ZeaBoqdCfEsBU2saii1+NFrmuy4ltVjPm39ybxfU2mFrxj+0TID/aPF0T552A/SB7mUi2X8qAOi5yJ0DI2esq9eviR2mWaBBmBfOXfLLYnU/gyI1gH/47+nhkHDDi45TnT7xOE48Yr+OKlzalWCa8dD938fceVijwyd1+d20IutSKAtdl1pg42pwYlCylz7qXFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(31696002)(186003)(83380400001)(478600001)(6666004)(53546011)(6512007)(6506007)(26005)(31686004)(2616005)(86362001)(4326008)(7416002)(316002)(66476007)(66556008)(5660300002)(235185007)(36756003)(33964004)(6486002)(66946007)(2906002)(38100700002)(41300700001)(8676002)(8936002)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZuUWN3Smo3dWFFSk5JSjhoZmhVKytJWFRSSkt6Y1dmNGFnQkZYTk9BV3Ev?=
 =?utf-8?B?TFFvVkk1a1BXdVJDTkdxOHBUODd5YU5OUmhqNENwK21SV3ZQcGd2QkhKV3py?=
 =?utf-8?B?VHl6eHRHWmJPODV2QzVyU0l4bkdFWHFUT0dmLzVqeW0xb0ZUbTJGZXozMWV5?=
 =?utf-8?B?TUk4OFJvT1drZzNkeFZNVHhTTDZsRmpvTXBjcEJva25CaG5oWlhIL1FKbWNI?=
 =?utf-8?B?a0hsMGtDZG0wbjA0TG9CamhkZFA0R2FFa1NmNjVzNHNkVmVkQ0hsM1Y5aFF2?=
 =?utf-8?B?Qi9RdC9kcW43a2Y1OXZwTDNLU2N0amhRQ0NjVXV5NXR0S0U5VjIrdzVWNW1Y?=
 =?utf-8?B?K21GVjJ3MzlLUmlvMzhGVnQ5L0JDQTdCeDFqTnorMnlOSGR3aW9NWXdpRVpJ?=
 =?utf-8?B?WTBpTTQraUo4bStVbWFnK1Iva2wrdHU0UXRMcC9TN3I5YzlTMFBVbnk1NW1Y?=
 =?utf-8?B?SWcreTBmU1lJL2tuMFRxTENLVzRFS0RITVJUOWFvMnUzYWx0ZUxVcUYyY2dK?=
 =?utf-8?B?VmFUUFJ0T1M4TnBTenovNnZzczVBT2U3cVhxdnJMYktFRHYzL1R4bk9sNERY?=
 =?utf-8?B?c2Y2TG9KREg5UHlJSmhOaGVzY3Rmei9Ha3NCR3dPZTRYYkdTRHNmeEVGSU10?=
 =?utf-8?B?ZGhCb3VWVWdFOTVCaCt1WkxaM3d5QkRPVCs4bXdZMTEza0xOU0hRcFV2c1g3?=
 =?utf-8?B?NElCODB3ZG9OTllUTGdkeUtEYjQxaDI1ZzA2eVlGNG13a3QxeHdyeFZwcnNq?=
 =?utf-8?B?M0VvSFRJcTFqY1hwZmxLNHpqbHMrS3E0Rk5JZDRxaTlmWFNrWlRSMGc2ejJT?=
 =?utf-8?B?SUUwTHRIYTM2cHRtVzJUd010ZGhpYVEyYTlUaXNBZG1nWml4WWdYby9XWmtn?=
 =?utf-8?B?ZjN5cHRJV2VSdXQ0dEZCUUJzRUlsbXBVSjYxWDZCMHpoNGpTMnFSNS9DbnJn?=
 =?utf-8?B?akhlMlJsMDhKbDVLYWdvK1J6Z1VGSEpZallFUTdzcWhVQ3dnSE45clhWU1Ay?=
 =?utf-8?B?Q3J0ZWNOb0d5Znh3QWxVV2gxZXFFVkZNb1dRSEdoQ2M0aTJVQzdaWWF4TXZ1?=
 =?utf-8?B?WDMweUhhRG15Yi9VMEFXODV1UlVpWjlmd0VlSkdwU0JzWXFGdGViYW5Mb1hu?=
 =?utf-8?B?enpseXUwaEtpakFScFJaUXl3SXBrd1ZyekZtL0M2Nm9mdzFneUtuYy9vUkxE?=
 =?utf-8?B?ampqaEtObEFiYmsyVTNEWFFJdFpXUU1nd2hadkJ4ZnFzRi9Vb2FCU2grcWZq?=
 =?utf-8?B?WUpubWE1VkFMZnhHU2ZrVVg5a3lObVoyQW1BY0JlTUliaXRuWmtKOU9wa0t4?=
 =?utf-8?B?VmovMFRzQkhVbERvSFBuODZpck0yNWdreHFGbzZTZXcvSGxNZmNjZUg4eEdW?=
 =?utf-8?B?SFhSZVpWWTNLTk5jTnNEeWF3RnIxZTBEb0wvWmpyK3FPdS95ZHlYUEhoSlZu?=
 =?utf-8?B?WUFyL0h2ZjdtSnVMc2dCZkNIVmNTOEw1U1RxK0ttdGxYTEJPTUY1U1JCdDh4?=
 =?utf-8?B?UmhrZEp2ZHZmanhzTXp0OWhXc3RoZTJ2MWIwa2xSSWdTTkdTbTcyNjJWNHVy?=
 =?utf-8?B?Zml1TTJXek13MXpsdk9VQTdWNThXZVg1VEY0RTRjamIrbzAyOTMreUZaVHY3?=
 =?utf-8?B?Yk1HNnNBK2lGbDJCZ1I4OFNVNmVXSlNOa3dPYkdSc1ljK2x0WlhmczJ0d2U4?=
 =?utf-8?B?L0hNeGw3c29Mdi90ODhacHJYMmF3dGU5bUI4Nk9MT1ppdXVvSmRSUTFGNG5L?=
 =?utf-8?B?b1MyV1NwaG9tNlg2VUJCTDYxaE05VDFaSURkY2xxOTdZb1hxdldOazhvaER3?=
 =?utf-8?B?YTZleXBIeElza2xZUDRqY09heDJlcE9tWVF4OVc5eFVRM05xbXdQUDYzZE92?=
 =?utf-8?B?UzVzUGYxT1g1Vy9maEZQZlFuVk5qQUVkR3dHeW53KzZpMFRGeTdpcGUyYzJh?=
 =?utf-8?B?UFVlVDcwNG1YZXVQcWxPU3RXY3NUbWJkMldLeTN4MFhIaEtsT3ZRSE1Na1pD?=
 =?utf-8?B?TERTdlFWNzBxQmQ1L2hMemJPbGp4UHlyODhJRHV2cGsvQ1plR2duSXZ6RzhN?=
 =?utf-8?B?d1kxaXRrcTgvV3lxOU1PcE9TLzhuSjRTOVBNSDdZZWNmRHhMSHJ1a2tOWkJI?=
 =?utf-8?Q?IluZx3axUdRZsk1A0fM325ii0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cc9787-2aa0-46a2-4345-08db66ca13aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:10:30.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSG/oRbU+b6FQpQviXXa/Kfr1dd35gvW0Kbi3hN+fIcqK5gALPztYUAa8ZE4pvLBB/NGiVEBy+mAuPqbJfyo+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--------------jP6YgWTrDDApUlrGwhMuU180
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/23 00:38, Muhammad Usama Anjum wrote:
...
>> +kernel_header_files:
>> +	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
>> +	if [ $$? -ne 0 ]; then                                                 \
>> +            RED='\033[1;31m';                                                  \
>> +            NOCOLOR='\033[0m';                                                 \
>> +            echo;                                                              \
>> +            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
>> +            echo "Please run this and try again:";                             \
>> +            echo;                                                              \
>> +            echo "    cd $(top_srcdir)";                                       \
>> +            echo "    make headers";                                           \
>> +            echo;                                                              \
>> +	    exit 1; \
>> +	fi
> Thank you for adding this. This is outputting error for every selftest
> directory. We should try to make it even better by just aborting the
> Make-ing process the first time headers aren't detected. We can do this now
> or later, fine by me.
> 
OK, I see. Yes, this can be improved by adding the same mechanism to the 
selftests/Makefile, that is in selftests/mm/Makefile.

I'd like to keep both, because as I mentioned earlier, mm folks like to
run just that one Makefile, sometimes, and selftests/mm/Makefile is not
invoking the top level Makefile. Rather, it includes lib.mk--which the
top level Makefile does *not* include.

Arguably, using includes instead of recursive Make, would improve this
framework: reduce duplication such as the above. But that's a larger
project and just food for thought at this point.

Anyway, this works nicely on my system, and I'll attach it as a patch
also in case you want to try it out. What do you think of this:

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 90a62cf75008..bdca160063d8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -144,10 +144,12 @@ ifneq ($(KBUILD_OUTPUT),)
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
   KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
+  KHDR_DIR := ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
   KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
+  KHDR_DIR := ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
@@ -161,7 +163,7 @@ export KHDR_INCLUDES
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
 
-all:
+all: kernel_header_files
 	@ret=1;							\
 	for TARGET in $(TARGETS); do				\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
@@ -172,6 +174,23 @@ all:
 		ret=$$((ret * $$?));				\
 	done; exit $$ret;
 
+kernel_header_files:
+	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                          \
+	if [ $$? -ne 0 ]; then                                                     \
+            RED='\033[1;31m';                                                  \
+            NOCOLOR='\033[0m';                                                 \
+            echo;                                                              \
+            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
+            echo "Please run this and try again:";                             \
+            echo;                                                              \
+            echo "    cd $(top_srcdir)";                                       \
+            echo "    make headers";                                           \
+            echo;                                                              \
+	    exit 1;                                                                \
+	fi
+
+.PHONY: kernel_header_files
+
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\



thanks,
-- 
John Hubbard
NVIDIA

--------------jP6YgWTrDDApUlrGwhMuU180
Content-Type: text/x-patch; charset=UTF-8; name="selftests-makefile.patch"
Content-Disposition: attachment; filename="selftests-makefile.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvTWFrZWZpbGUKaW5kZXggOTBhNjJjZjc1MDA4Li5iZGNhMTYwMDYzZDgg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlCkBAIC0xNDQsMTAgKzE0NCwxMiBAQCBpZm5lcSAo
JChLQlVJTERfT1VUUFVUKSwpCiAgIGFic19vYmp0cmVlIDo9ICQocmVhbHBhdGggJChhYnNfb2Jq
dHJlZSkpCiAgIEJVSUxEIDo9ICQoYWJzX29ianRyZWUpL2tzZWxmdGVzdAogICBLSERSX0lOQ0xV
REVTIDo9IC1pc3lzdGVtICR7YWJzX29ianRyZWV9L3Vzci9pbmNsdWRlCisgIEtIRFJfRElSIDo9
ICR7YWJzX29ianRyZWV9L3Vzci9pbmNsdWRlCiBlbHNlCiAgIEJVSUxEIDo9ICQoQ1VSRElSKQog
ICBhYnNfc3JjdHJlZSA6PSAkKHNoZWxsIGNkICQodG9wX3NyY2RpcikgJiYgcHdkKQogICBLSERS
X0lOQ0xVREVTIDo9IC1pc3lzdGVtICR7YWJzX3NyY3RyZWV9L3Vzci9pbmNsdWRlCisgIEtIRFJf
RElSIDo9ICR7YWJzX3NyY3RyZWV9L3Vzci9pbmNsdWRlCiAgIERFRkFVTFRfSU5TVEFMTF9IRFJf
UEFUSCA6PSAxCiBlbmRpZgogCkBAIC0xNjEsNyArMTYzLDcgQEAgZXhwb3J0IEtIRFJfSU5DTFVE
RVMKICMgYWxsIGlzbid0IHRoZSBmaXJzdCB0YXJnZXQgaW4gdGhlIGZpbGUuCiAuREVGQVVMVF9H
T0FMIDo9IGFsbAogCi1hbGw6CithbGw6IGtlcm5lbF9oZWFkZXJfZmlsZXMKIAlAcmV0PTE7CQkJ
CQkJCVwKIAlmb3IgVEFSR0VUIGluICQoVEFSR0VUUyk7IGRvCQkJCVwKIAkJQlVJTERfVEFSR0VU
PSQkQlVJTEQvJCRUQVJHRVQ7CQkJXApAQCAtMTcyLDYgKzE3NCwyMyBAQCBhbGw6CiAJCXJldD0k
JCgocmV0ICogJCQ/KSk7CQkJCVwKIAlkb25lOyBleGl0ICQkcmV0OwogCitrZXJuZWxfaGVhZGVy
X2ZpbGVzOgorCUBscyAkKEtIRFJfRElSKS9saW51eC8qLmggPi9kZXYvbnVsbCAyPi9kZXYvbnVs
bDsgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKwlpZiBbICQkPyAtbmUgMCBdOyB0aGVuICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAg
ICAgICAgICBSRUQ9J1wwMzNbMTszMW0nOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAorICAgICAgICAgICAgTk9DT0xPUj0nXDAzM1swbSc7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgICAg
IGVjaG87ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcCisgICAgICAgICAgICBlY2hvIC1lICIkJHtSRUR9ZXJyb3IkJHtOT0NPTE9S
fTogbWlzc2luZyBrZXJuZWwgaGVhZGVyIGZpbGVzLiI7ICAgXAorICAgICAgICAgICAgZWNobyAi
UGxlYXNlIHJ1biB0aGlzIGFuZCB0cnkgYWdhaW46IjsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKKyAgICAgICAgICAgIGVjaG87ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgICAgICBlY2hvICIgICAgY2Qg
JCh0b3Bfc3JjZGlyKSI7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAor
ICAgICAgICAgICAgZWNobyAiICAgIG1ha2UgaGVhZGVycyI7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgICAgIGVjaG87ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisJICAgIGV4
aXQgMTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXAorCWZpCisKKy5QSE9OWToga2VybmVsX2hlYWRlcl9maWxlcworCiBydW5f
dGVzdHM6IGFsbAogCUBmb3IgVEFSR0VUIGluICQoVEFSR0VUUyk7IGRvIFwKIAkJQlVJTERfVEFS
R0VUPSQkQlVJTEQvJCRUQVJHRVQ7CVwK

--------------jP6YgWTrDDApUlrGwhMuU180--
