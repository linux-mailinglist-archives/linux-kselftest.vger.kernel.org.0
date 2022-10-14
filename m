Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11CA5FE78E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 05:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJNDYo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 23:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJNDYn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 23:24:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934B250
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 20:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awk3dIHqRQeFeljrZY23PfGZ/aPDpxBOrhic9lbhc42MSsTTPDYp2jIdk77OTySFDNVF8kvQZNYMcSEACzYhrPPNyrE6vntlkWO86DgxxtvFigS5GU6glNGmxlQA9wrVNdD/uoV0n3BosUIy9cnAmLP45+/1ZqxYqscahvt0kh7Ic0fvKJjxqL/5vF+FzYPoj4lfM9edBRVtyK1cQJotgymw/D45eLUxlr8KsPuFdGyzdbNiDnTBYUQVuf3eSPbyCn4Rs1EiBQ2SUmZiTt+vFHiF5x660+6EkDWnHW67d3yGPcBMTNm5Gw4TvkW1Tkk83U/mLcHBWO3oX4HQPFXs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NnTKHTxn4XcR099d+0pnFulDUANkdqTQvt8kcWf4lE=;
 b=eLaDXEEykwLpr3/sxwjt1dmOTQqHjCAaTgyD777mJW/OUe7cStb5p3LC4nnvXROqx1nEbwPwElJBDfV83lxYehFV8NB36dY/PrFbtNRl6E8mqm70ARf7iakAjx7ZgFeUkGA6uZA4FX6DlXuUn4jUgPS82jHjp6TB5lnKRvGAKYo5AQOpF4LCENVMISh96Mrnf8ey+CVIz5kSqDEN4d2CmCPK9pt1apinmFyHDbBpmgZr8ay4CIdrw7cPEfW7D7MwPup+Ko+Cpr1H/uyE8JzIxxM5flKlphyDFQaGaht9Edd7wWLywVVTbf4soVDiCSd50ugHUDsxrxupeGJ/ksSXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NnTKHTxn4XcR099d+0pnFulDUANkdqTQvt8kcWf4lE=;
 b=HndbJys3MAryA8fo4ZkP0Fx9rrSW+rDWKOSGOqMD8SGge2GkP/E0Gzm7YnLAX2XgiGcM0pjNGA58gwwICWZyd97JZljqcb5a/hE4dqQmZhJGrmwGwteHFuGUdeAg4gt/dW8Bl0mthtQm9/UpwjDQZ/SApNBHg85+CqCP50NQdjTpsElFlK5Wb82qEWN3cUOh0GCqAHyvBXoJo+uKAtypzMelWvFvNLjY/+t3WrPg48YmNN6kka3xIywljhJVOXV9WhW9K/iVmc22EA25PfNjP/OitdfiWiURFm3nUi9cE7wPEYn+47/m9e4EKYMoCL0MD16M339aI2SpXVxDYI9UEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:24:33 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936%5]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:24:33 +0000
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
 <7e2e6679-3205-3540-f522-9eaed2940559@redhat.com>
 <44fcecda-31a4-7288-1848-63003dfe0a7d@linuxfoundation.org>
 <04114304-7b35-d42f-0155-087e3b6237c6@suse.cz>
 <0e02ace6-2fad-47d2-03b9-d8a46f256097@suse.cz>
 <ecebc355-eff8-0046-3749-8738ed1954de@redhat.com>
 <a7b3cf86-4578-c23d-7326-4ddf7dcda043@linuxfoundation.org>
 <2d4b8d64-f17f-90ad-7328-b5ca7537d08a@suse.cz> <87fsfrjgq6.fsf@nvidia.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: hmm_test issues with latest mainline
Date:   Fri, 14 Oct 2022 14:21:57 +1100
In-reply-to: <87fsfrjgq6.fsf@nvidia.com>
Message-ID: <87bkqfjdec.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: f02b7887-8a42-42fd-88e3-08daad939cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFE5l1i36WSCC2oQSeh8to/HE/B9UcWqcPhAo2JdA2G/q8n7Xp/NKrlj76YJZ2lkZXX4cCgx5MBqzDpwV+CtUdjWbQdY7biFggQ3AP7oPkBjpXv+/DRWseDgdXuziSwQSJwuYzIG630Ca/t5gLgrQt8dk3/cIADyvxVHuPYpPOIBvkzSO0H1VcxFVqFQtrVjNLzsf23+rtLGH9ubmM6o1o2DVHZtjcnBwHNdltIyhlDkRiIsUpyKs8TVp6AgFa33E/Zg8extgUsuEP3FwBR4RopsgxJRYUIjKo9E6RIYQXCoGz6Al5UQsZf8u8h0NOrTxisXgjKPfr/wM6DNnOuBUfCzednucn99jqjYYh7iheHzIUv3WefjAGfMQkb+CM0PWJEa5Lgg3FUPGM81zoBnnLyftzCuQnHjZSoUqfjhbivFeFJIOyaEqkpgnj6iMU6xR4bNgDZ2dn8bp1vXMwpF/9EGHstCfALe3f5IQBPdW77CUn022hWmDPBy3gw+lDA06X0+bf/bkcY6+0qU7+duWlAI40u45eme95KklrMrNj/o+wa2PdhG+4oDcEt0S4VZxM0QeGvDniVtZIRpV1whP2q4uq2IJs2hnG6XyN3GOrkDeBUdewVSoj2Rs84RAvqe/xtE5D79muYk+L1i9dhQG+FEUrYQYYKOzqXlMHfYsVdgLVqs1Kn/Dmre+BztpxqWFuZeq3YpqefTg4zUyw/ZUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199015)(83380400001)(2906002)(66476007)(316002)(66556008)(186003)(66946007)(4326008)(8936002)(54906003)(6916009)(86362001)(8676002)(36756003)(2616005)(41300700001)(26005)(6512007)(6486002)(53546011)(38100700002)(6666004)(7416002)(5660300002)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIt6gOL4oCxEf8E773VNGo9ithEktFImM1HLJ7Got/cAeCaPzF731kqWW3l0?=
 =?us-ascii?Q?b8a/hroVMjIsCWG14t8n3d6nA3LOmff+C2AvpSEFEG2X9Jr3inSVmz/A22Ey?=
 =?us-ascii?Q?z5P43XfzMQ5yn/Jd784S7HZkSREQ8PnePxsHVz5W0FWacz1eJJScu+MbuWev?=
 =?us-ascii?Q?qXyxM7l2+Vw09iDP6pg3zfJLv0op0rzdJJ+vHngI13cWeLnqiGSQBZZdmWf+?=
 =?us-ascii?Q?Sln2uNSYTNpXT+Rdj+BU1UsY9fiKdECX+DvfJ2bjgebbaIJMtE3Q/E9rr0L8?=
 =?us-ascii?Q?GpyqsU6w458frg6TNVqWKE3XQIWeWxOrNrj+t4uYhyevzTGI+EqeQILXWPcF?=
 =?us-ascii?Q?BZB6dItXuk8HqAm2qD5ngRhFYWe17fyJQ+Nk3lBmyyv7tYNDsuGLGe2/mNRS?=
 =?us-ascii?Q?UaCIszWQkX2HIgcGW59LKu2QjPKAA5CVrElv6QjgQb4nYX84LqlErPJlSMca?=
 =?us-ascii?Q?p0q6P7vF5U59JVEVXoDy5+pl6aP2HOIBkY90jTUcoOqFpYJwQE8XFCtQCfOE?=
 =?us-ascii?Q?mY62TTzl+tCcIwLq3Fos3TJyu7UchC2Crt1Cbft4g/3XwLC+nn1yeS2Zoegw?=
 =?us-ascii?Q?F6lms4rKW1oSy6sNPsk4wME8+8yQeOcbPAaZvC0IJ34pzEVnH+AoNQFjnhhx?=
 =?us-ascii?Q?pPzcvX7LhLLady9ifx1kvPk8flUbBGGPMC6Wnqm+zYuzXzl73wgcIWJt6xvI?=
 =?us-ascii?Q?LqHZHOqi0eX6vDt+j+vnz0aKeO5ttIMROkCQ/Uu3MVOLN355kXj1s5zg1zpL?=
 =?us-ascii?Q?/alyglt2ezETaq30IDBr1Ds7qywVAQ5e2VxCAe5eWUne2Gt6fjQwJwWlbLmq?=
 =?us-ascii?Q?JiZz6RjncTGfbx2IRoPipoL9z+acDpul4JLkm+MVMu9FwH3CViXEPhO9+7Si?=
 =?us-ascii?Q?nz8ERUCpahXNdj0uGyBCEEjagrajEq9ClmmfKLG56L+tEqiXHZ8iS86m0XlR?=
 =?us-ascii?Q?n6rJ2Ez2nqJQaM/7l56D/dygW/Le2RLnl8URFhBBXpF4ALg8dMBj3HPLLqaF?=
 =?us-ascii?Q?SxxN7SnEZglcqJiJhO5FGszlHRKd3LTPCSr7/V0NKpiuzJc04L6+mS5dsQlh?=
 =?us-ascii?Q?qOtq443QRscNinS0g7/9iqBQoGPdVCVnQQ+ZrCZEk9eCKLvyX7p4TO+B4A1D?=
 =?us-ascii?Q?ne34AsMMYPg9lXMFR6hzQulGUxBvoZt8iNuxFcmzB75VYFZ7sRDVoEiBWqXz?=
 =?us-ascii?Q?fqspROLMuGstsnENodGdpEoeaUPyUWsXLXDp6hG38bv71bvEKtAVV/TX/oBg?=
 =?us-ascii?Q?3aVdMQ7jWVbyGsTZsLSVTu3bSq8oSDiQ+anxHwJl1OUfUOG+HBhm5QKZOXaX?=
 =?us-ascii?Q?MTJSP5gqAyF39/HzOoVZAV0GS5qUA/BF7i+NvifBL08+L5Z16bqJd26rHWBp?=
 =?us-ascii?Q?TyAZr6IDnmle3N/uy7kvSJnRI3064rQCpVuidkPwJMa56JixHIB2N6V3q8SW?=
 =?us-ascii?Q?kPmnQmyiir5dxoohOzcgIanEeDDWbrkTwqHXDPuHdvo/8lavtKhLX0a+/PAZ?=
 =?us-ascii?Q?OLEmzWm0/ieMEFRJD3f5Xpz57cr0ub+C60StpxtRTaPFzr7tKoQ1lUrs3RzD?=
 =?us-ascii?Q?55BA9jza/BAHUM4INmlMW3RctN31A90QcyIrkbLG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02b7887-8a42-42fd-88e3-08daad939cec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:24:33.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +okVsh7FlESwTvZcVcjrFkC50wFraPsurO5ZW7bulbh7EPbt9WPWp9E6/bHRhhdAuaVPuyZi29LjOOVtFHaC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Seems like this would fix both the SKIP in FIXTURE_SETUP and ASSERT in
FIXTURE_TEARDOWN issues:

---

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 25f4d54067c0..1998fe888f8f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -387,12 +387,12 @@
 		if (setjmp(_metadata->env) == 0) { \
 			fixture_name##_setup(_metadata, &self, variant->data); \
 			/* Let setup failure terminate early. */ \
-			if (!_metadata->passed) \
+			if (!_metadata->passed || _metadata->skip) \
 				return; \
 			_metadata->setup_completed = true; \
 			fixture_name##_##test_name(_metadata, &self, variant->data); \
 		} \
-		if (_metadata->setup_completed) \
+		if (_metadata->setup_completed && setjmp(_metadata->env) == 0) \
 			fixture_name##_teardown(_metadata, &self, variant->data); \
 		__test_check_assert(_metadata); \
 	} \

Alistair Popple <apopple@nvidia.com> writes:

> Vlastimil Babka <vbabka@suse.cz> writes:
>
>> On 10/13/2022 9:38 PM, Shuah Khan wrote:
>>> On 10/13/22 12:00, David Hildenbrand wrote:
>>>>>>>> When did that test start failing? Was it still ok for 6.0?
>>>>>>
>>>>>> Didn't test yet, will try, in case it's my system/config specific thing.
>>>>>
>>>>> So it's actually all the same with v6.0 for me. The infinite loops, the test
>>>>> failures, the misreported SKIPs.
>>>>>
>>>
>>> I am not seeing infinite loops and seeing 25 failures which could
>>> be skips.
>>>
>>>>
>>>> Is the kernel compiled with support. I have the feeling that we might simply miss kernel support and it's not handled gracefully ...
>>>>
>>>
>>> Here is my config
>>> CONFIG_HMM_MIRROR=y
>>> # CONFIG_TEST_HMM is not set
>>>
>>> Okay here is what is going on - hmm_tests are supposed to be run
>>> from test_hmm.sh script. When I run this I see a message that tells
>>> me what to do.
>>>
>>> sudo ./test_hmm.sh
>>> ./test_hmm.sh: You must have the following enabled in your kernel:
>>> CONFIG_TEST_HMM=m
>>>
>>> Running ./hmm_tests gives me all the failures. So it appears running
>>> hmm_tests executable won't work. This is expected as test_hmm.sh does
>>> the right setup before running the test. We have several tests that do
>>> that.
>>>
>>> Vlastimil, can you try this and let me know what you see. I will compile
>>> with CONFIG_TEST_HMM=m and let you know what I see on my system.
>>
>> Right, I didn't mention it, sorry. I did have CONFIG_TEST_HMM=m and was running
>> "test_hmm.sh smoke"
>
> FWIW I tend not to use that script on my development machine, mainly
> because I either have the module built in or otherwise don't have
> modules installed in a place modprobe knows about.
>
> Anyway I am not seeing test failures running hmm-tests directly. However
> I do observe both the issue of SKIP in FIXTURE_SETUP() being reported as
> a pass in the summary, and the infinite loop on ASSERT failure in
> FIXTURE_TEARDOWN.
>
> There does seem to be some framework issues here which are causing this
> behaviour. Consider the following representitive snippet:
>
> #include "../kselftest_harness.h"
>
> #include <stdio.h>
>
> FIXTURE(test) {};
>
> FIXTURE_SETUP(test)
> {
> 	SKIP(return, "skip");
> }
>
> FIXTURE_TEARDOWN(test)
> {
> 	ASSERT_TRUE(0);
> }
>
> TEST_F(test, test)
> {
> 	printf("Running test\n");
> }
>
> TEST_HARNESS_MAIN
>
> In this case the test will still be run even though SKIP() was called in
> FIXTURE_SETUP. The ASSERT_TRUE() during FIXTURE_TEARDOWN results in the
> infinite loop. So it looks to me like calling SKIP from FIXTURE_SETUP
> isn't supported, and calling ASSERT_*() in FIXTURE_TEARDOWN is also not
> allowed/supported by the kselftest framework.
>
> Unlike hmm-tests though the above snippet reports correct pass/skip
> statistics with the teardown assertion removed. This is because there is
> also a bug in hmm-tests. Currently we have:
>
>    SKIP(exit(0), "DEVICE_COHERENT not available");
>
> Which should really be:
>
>    SKIP(return, "DEVICE_COHERENT not available");
>
> Of course that results in an infinite loop due to the associated
> assertion failure during teardown which is still called despite the SKIP
> in setup. Not sure if this is why it was originally coded this way.
>
>  - Alistair
>
>>> thanks,
>>> -- Shuah
>>>
>>>
>>>
