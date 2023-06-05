Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DECF722F6E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjFETN6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 15:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjFETN5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 15:13:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16982F3;
        Mon,  5 Jun 2023 12:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPgzMb6mRe2vstrEYP0jqZIQnrTUYtvfWxrYciPOmiU0QGihRAS9aQr7kmau/pnjsHEjkW0xDnjLQYgWR1Xg1ylAi8fi6gOZtaIRcttjSKoUtHfqu1CD1cwofk1szIFb76bKpTmH76Sf2e254b+sZ6CiblFBtXZR31mGuFOy/RNDPwIRXoNur8cCPbmtW4Rhoc4E+6Upiti5cAkSij4ByMY+9Fa6KayvgOTwrG57Z6/oCStGuQ7UP1kg0R6X1A5yTmE3wrxUye5mibqi5Gt5vo1FI3xaGNj/Bwckg1e4OAFVj1tSVfbip6YUjOIBcEaJPdcVpGKC1IjtUVxqUNYQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuX7kRNP0IahiB38xvWt0HUZkgEWRi/EyVIiPk7qU1o=;
 b=HAqwV1x8mIG9C5yE1bIG/0AaDRDWfn0m55hfulC3MFQlcXhGqZMi6Gf9Yt1Dik2hiWUR6pw4c29kKCrnxvpSiOxGo5U6KR7sabSz3VuEJcBfs5FUX5OYvPLqtTlI994MwxM/ybteYNDrHOVq3SV9UBOwp6TqzTTFT8m0hToZMGT+kW+IG5bJPuBQIwdPPwKWUTroEw5TpMfJynnLbm4DveReE7qmeSRW3KytpbNwFQSE6nCKpr4MF5ciaUNkVwVxw5g/C0RwwGrbI/v/EZsOsj9XNmQrE7QLndzkh+fZuEuFckHXt+L3D0zTXQvUed4L2MopVVdOLlI2MG3xHfpLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuX7kRNP0IahiB38xvWt0HUZkgEWRi/EyVIiPk7qU1o=;
 b=hWtKWRh9kvBb6fOq9ifD5qmPGzoO6WdGtGotjsn6ZkwQS1/tcNSvyEBZrZapao7H8jhtED1utzEQxSva7Hgj8KAXuoId/XyPm/jFu3CgKR4qplqKIgSNzQ0cDA3Y4QHMYKVoDJtpP6gdSqKBek61HA9DqShhwr14gZqbtNzCC1KQAm59RH1/dG4hqnuFvK08QM/nmW/SxoDC2jAEvfcHRpIZMwPsb3CHr79sEJL2xV139zEeMGNHkdTlo0JTLWvfISE7NZgdvdfYWP6BdicyvLZN5bjDn/n0wyTHTgR/CHFEtKIDVR0n8KlzP99Y6iseL5kO9nLQXsCPvVwvh5T7tg==
Received: from MW4PR04CA0338.namprd04.prod.outlook.com (2603:10b6:303:8a::13)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 19:13:52 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::ec) by MW4PR04CA0338.outlook.office365.com
 (2603:10b6:303:8a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 19:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 19:13:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 12:13:42 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 12:13:42 -0700
Message-ID: <8adfba9e-b514-50ba-9afb-c06e8e446a81@nvidia.com>
Date:   Mon, 5 Jun 2023 12:13:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 05/11] selftests/mm: .gitignore: add mkdirty,
 va_high_addr_switch
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-6-jhubbard@nvidia.com> <ZH4FFa4FV9KGwBZo@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZH4FFa4FV9KGwBZo@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f027f6-b61e-4cbb-4e0e-08db65f8feb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jc2pnd6v77lCUbOAiTGrQPv38ckgkNvpIvHjbAMw9JI2xDjcOx1FZ2j2N6iUqfvAuVWmm1gj9rcgZvGPCb/fB4DMVX4L/b11dWdu0jjfsNy6TvPNoeh8yfU39GEOa/cpiixLsRSQ6ne/fh8on4FVXiVxfO4wA6FIEiTHhNbG8xd/kJkSaVmsquqoti2IygKuZt8JC4di1TXeewfr1Gaeqj2/2vKaA2WRWp+U396qlseMM6GVy7THutp+spMv+pIpNaWt1H9KodAWJI+g51ydojQDGqb1C8PSFxOPPSuHvUKMhgQ32yLMkX1iD+2ni6cLKrixeAGLYAW9jmHuWM+G66Db93WcxutNFwZ7c8ke57+pwBtEj/UjC/9Wp1fnagrxmRERb8WPdyfyaR2/ku1DWdzOIraireq/QePDzngcs/CJ7VFooKd1H15zUAk6RBySmzQhjnyxNFMoKib8l2G0h162qpj8hZ6PxxrLIYWmtnZj7W3gQqVb6j8G7UYUdkW+RdOtyoPofB0SjFz3wtVSxoHiYb/g/Ih7yca22in7aeEnlgJx/dnUnXzSzXu49v2cupSEYEOxdrqsuGJUWrncK1fGqVTzv+6dNk+8nwUap81U4MRXqmek5+YpNvHUK5/VjKK/iCv1g5Oa6wf58VSxIa2lOkT7AvudrTjAoPuCs6QsOjhagT6gfL4CMh7ctRRTT5nk7O8zxDziIOHnQZ5P7M0GM0NkfCByfB5/EjGpNZfzd3vcck1uHOmOR1YvaemtkEbXloaUe9p75uU7v5iEaQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(53546011)(2616005)(41300700001)(336012)(426003)(31686004)(47076005)(186003)(26005)(36860700001)(16526019)(40460700003)(478600001)(40480700001)(16576012)(54906003)(4326008)(6916009)(70586007)(82310400005)(7636003)(356005)(70206006)(316002)(82740400003)(5660300002)(8676002)(8936002)(31696002)(2906002)(86362001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 19:13:50.1840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f027f6-b61e-4cbb-4e0e-08db65f8feb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/5/23 08:53, Peter Xu wrote:
> On Fri, Jun 02, 2023 at 07:15:52PM -0700, John Hubbard wrote:
>> These new build products were left out of .gitignore, so add them now.
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   tools/testing/selftests/mm/.gitignore | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
>> index 8917455f4f51..ab215303d8e9 100644
>> --- a/tools/testing/selftests/mm/.gitignore
>> +++ b/tools/testing/selftests/mm/.gitignore
>> @@ -39,3 +39,5 @@ local_config.h
>>   local_config.mk
>>   ksm_functional_tests
>>   mdwe_test
>> +mkdirty
>> +va_high_addr_switch
>> \ No newline at end of file
> 
> Maybe also the new gup_longterm?
> 

Yes I could add that. It might make slightly easier for Andrew because it
would preemptively avoid a minor merge conflict.

Unless David is thinking of adding it to another version of that series?

> Reviewed-by: Peter Xu <peterx@redhat.com>
> 

Thanks for this (and the other) reviews!

thanks,
-- 
John Hubbard
NVIDIA

