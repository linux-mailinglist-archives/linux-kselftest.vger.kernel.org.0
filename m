Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2057D2CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiGURxH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiGURxH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 13:53:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BF84EC7;
        Thu, 21 Jul 2022 10:53:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHSued016858;
        Thu, 21 Jul 2022 17:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ChBOQR0zmNyo0Zf+mDHFxek1YikANissaHMnCIhmmJQ=;
 b=VWDL9Mqq1Y7d2d0SmU2JP8VPaXg0qQ1/LSYZ2+Szt8jH1CHmuTRy7utMJEk8VSxIoIzv
 0RjZHupgN4oAvuaFMqsXR8W1SHpvW66bUh4kYTGtsb+wVgCYB1V5xYxDZ8YWWMOmJ6qR
 /6bp2s7sopfNGkqN86pBPctgIjKdjtzl7OFqdlcxKk2o7xVSpY/CrBr2Z3YgT/PtUe3B
 mJCw+5hVlbDJkyZLDF5W7/L3FkdDdtLrS9ZfhdaNbZ2Ningd1laQo4uY6FXMK5vGEu4B
 X/kWfH8F9s+ykg0ND5eCHGTNgGkFK4LHGqh60f0fplel2QAQePU0QprQSc2iboCtBmzC Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtnc6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 17:53:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHHdwC010041;
        Thu, 21 Jul 2022 17:53:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gjqyda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 17:53:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs1uq9vUKGAdTm+ycBkEnC000MFIrWV0VBORdt9RjJuuYZFloDhnmZTC29kkrEuRUPV6ulv5MlNGBCchuYC6mbz1iPCzwQ5arK23P7XM+g5qz7xcX9drVNwwZRq9cwBUg8EAkT6EmSuUClLqdf7fSlFVvEojMfFgNeF2C/+i8rwNQrQQlSwDrMwd9BrZ+IXaQiKYaFcOjy2gehih34B2Gt2UvJikq8GtYrL61iwyoDtFT3R0OK8uXNKx7riGlb2TxNE0CiySlHd0ENbz+OPtjex276G6Q/6ja/vYYDjYdDNLHzPP5xFklq5GsTmt0wUc7HyA6xkW9SJwNa4AUlLWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChBOQR0zmNyo0Zf+mDHFxek1YikANissaHMnCIhmmJQ=;
 b=kaLxX0uSK8PSoptqr8Fo90TTYaoZ4MN1o0WVg3scqaE9+oc1z+JkyR1+EkP9gKbJSa7nL5jL73QA2j7DDV96nY6GT8mRZJQukwpuosW+D5vhRA0TIIUzvoa91ZYXRUJKqDHucjx2y+f+xYF6F2uuKniPooUOYMIhqRaPIWp81JoGvCjbYwVdG88FAUiH7oZUqqIfxDBnlDI6jLzGbSALZ2Sd3rDDZbIwAw9aYqQa9ytBe4QATiPudqmznlfmz7uk9F9HJ6+ZAHRAYn8XR2Ykwe+Uvidn7/dUy8MrxWeNx9K453fBJabhpLLLhlGU/62APuQnOoAKaNQlKEwikLmtaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChBOQR0zmNyo0Zf+mDHFxek1YikANissaHMnCIhmmJQ=;
 b=l0zp2qCVDCg3ZxV7zMO6ecImix/O4dmHkaCtvWVbKuGuNgbBXA5tBwtI2mQfWjSJngzBDDXa5UAUplLRvGcwZ9cDugcMqWgFua/zkf+dUXUT4GyLWtdBg80D7f6+Z8uo8uX/Fo2IWoWEHwT68eePQTZvrfDNkv8D9z/G8ZoLQFo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2619.namprd10.prod.outlook.com (2603:10b6:5:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Thu, 21 Jul
 2022 17:52:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 17:52:58 +0000
Date:   Thu, 21 Jul 2022 10:52:54 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] selftests/vm: silence uninitialized variable warning
Message-ID: <YtmSdjr4oMW+mVax@monkey>
References: <YtZ8mKJmktA2GaHB@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZ8mKJmktA2GaHB@kili>
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e17f62-3b46-4c7d-97d4-08da6b41d898
X-MS-TrafficTypeDiagnostic: DM6PR10MB2619:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87PmqudtBIKZ94iW+WjZI0HgWf4iH0ME9ztPqBl8eFxQdpnjlLweFDgvLyIGaivzA0WRvaHwKZ9c0Of9Ld+aiinYqnAfmRvIkw9pysvItGc11WWAU5WTQq3PkCX5zDHlPQ9Xm6MhTSfQNGzvYdkC9CL5Bb8DawHVw9h8fMNTI99Zhg6KLHhxhPJ2HqcwaqapA90BNKmctQv2Ov4JoivGX60M4zN+lku/obTUUC5wtaGqgBY5RzFFcPbxn1/VRZ3IfyGAn2gk9nzcqoCtuwJKQzn0hbi2wYfbjAABOTi/AQK/3GxfH0d6A40Kjzk6DaS4gjXadhpVqC9Lhqo6sy/uQHK44uCDyw31BFWR+DIplqGGob0T/WMGaaIKAaJutwsl83A7BllE4lxFEwGdxxg680pZzLwhVOEngWz6N31CMoj6woRmEUFrqfhyT5XwToz2QNv7oi/QUemHTIRHCkiUyVQttqZsjsWHfZXTiljzix65wCX1kyQkC90gH9/GRtaxdwWy7pD25W0rr3WbDvA8RA3190DEqRndvwnCG6qqsDQj01o9JnWPrKAYqA3un3iXzevcVQW/G7Ey8Yh3FlP867wNG2Shmk2mhWUaTSw5DuL3h3nFQxwCwOYHeURuCvfqtl+fA3LY4jUvopRonLJt/iRhvarJi2Rft6rStjdaaXVYY5VktZSzD7GGMUsA1BZ5dtdq4D1vNQmvdPB2MwiJ0RFIM8SyEIc45wnqfg62M5xsXRmKE5ozzxTEbTcihAmuEqxmDBuZNew0sWsVNJ6zjfUBdo22LDuBJNEc8g40pJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(38100700002)(316002)(2906002)(186003)(83380400001)(4326008)(8676002)(6486002)(44832011)(6636002)(33716001)(66946007)(26005)(6666004)(6506007)(54906003)(86362001)(53546011)(66476007)(6862004)(9686003)(6512007)(8936002)(478600001)(66556008)(5660300002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gi/FnXU/TTmAXQhVU/h6XpoZG5m+crJmF3045bDXIyyI312P4XTLX1beSHgJ?=
 =?us-ascii?Q?c8TmAl4dR9/3Lzf1u3QP8ea+BLXmvEh1jaqVjw+ndvP0otAmH2RniU8wE281?=
 =?us-ascii?Q?Gj7N5scnh8NwJEWN1uSQdSSNdEmObpLCMI7xMx1zJzS8nwuv3rm4Fb5n5J26?=
 =?us-ascii?Q?ews/kwoP+D5OQljTbeIV3q9lWK6RO1AV65xw4pYik17+HyctBbwK5t7pskAv?=
 =?us-ascii?Q?ry/i+yqIvB08lyg/YqORegDjpxNMF5a74lCIJsGe35VaF6qypbuyzt9BS/k6?=
 =?us-ascii?Q?G0MF+PJ5nhUMx0Y+qpUnQBpXAtklSP7Up7ZlJzPWvDo6JXITqKjIVM4oYo2x?=
 =?us-ascii?Q?y+spAWxrq1vkqf647GdNqI+gk+KzP6vKun6VzN1lX/QC+1Kmf65TH1oAcy9K?=
 =?us-ascii?Q?ocxitpJtslh80cdo8W4EVi2DWXjFRbhxNbkMVTvLRhtDdphQCGXwHO3PxP2v?=
 =?us-ascii?Q?/+Uzrt/EKM9vyx9jXCZtY7Fa19o58kEiWNG3/Gn2DikzWPw6aQii9aJdG797?=
 =?us-ascii?Q?eISOEk6zEIuS1UuAOWVC/2PoFPGzTFhhorE/hWMI4FuxoawvcU7AQh0rAk/Y?=
 =?us-ascii?Q?ugOelXtWLYu3TrhPCy7f3sqIXiauXJtXbYYELa9gqwBB6hl4NTkRDS+4kp8X?=
 =?us-ascii?Q?HLbwi4qJpX95YxrOWQ2q/0CoMoSc230huri+6VhN6V/w0wfO+alvzC1eG6EK?=
 =?us-ascii?Q?ZLrMLZYT6q4Zt+u4mpDPjyGa3cySiGum0n+rt6fZ5lzUFwJconK1Q08YnvM8?=
 =?us-ascii?Q?z1d7Bk8O3e2cQytNDNyvV65wiJRDNPCIaZ2a5W/Os6ajMan7tN375+PHCqvL?=
 =?us-ascii?Q?RxGna5kHwSHcd/81WLC+oWmYY7hkTsQk+Q0cyyqkVHNGIXR/SKvVL1pm1lMp?=
 =?us-ascii?Q?OdvVnCH946C5NVdbvNBPSBUwFB8drGhmKlff8gDMQSDlUnm/2gwif4FJMy8W?=
 =?us-ascii?Q?4A0EXySHpnZ4X1md79UcxeoE1i7OYtTuAgEILwQ9djLFFQIal0jLYLwoqbhE?=
 =?us-ascii?Q?NCv7iLHKwFsIox8oVlDDcgP6ZRFu9+mhZpfS5yhg/fUp/wy5sTVTMf0lhzoJ?=
 =?us-ascii?Q?OfNM8em6CSzr6lwCzGUwWm+aMq1xbM+4jbWEV41G9+8M8VbMsW0bcWZ5rqKR?=
 =?us-ascii?Q?k1zH96n+UtkuK720bG//f036P2rHEWfp12BqSeHUzgxVdgG803vx8GNAEO4n?=
 =?us-ascii?Q?SZT1fmrJR34YHeXGS0rRwuWmuxpL4XXGKSKlhbNg0wq1yiT7MAyohc3s2NwW?=
 =?us-ascii?Q?CAVrZx46BUOMa3WVBxdqim3CoUgtmDDEDLpWYe/24b3EGTgNMzeOFjQhluMq?=
 =?us-ascii?Q?wuIsOu6p+JKMmzu2HQD3NeMDUiFEn5gsuxTYzEEZFHHAIqmUn+RUhlC2cJHu?=
 =?us-ascii?Q?LTaaD68+3RHsUnLpQw3RF8/TKhUrjv/Fd4Yopuv+hdpdHX3kpgtSYfJcVbK1?=
 =?us-ascii?Q?YC8umdUhG5iPL5D6Afw+PHcHocrXBaxA7moV2BiIZkerIFzMLumNWQnFlL3L?=
 =?us-ascii?Q?3zl/eMW4Lpqn58ifLlXTfzZmjxMr24zj26CYgwZ+F900naWaK+tyZGUCxcYP?=
 =?us-ascii?Q?LEGZm76UejzRrm/KVBBDMb9XMs8QY2dGaBI7OtNCjw9OHTD0RI97SfyCNkmC?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e17f62-3b46-4c7d-97d4-08da6b41d898
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 17:52:57.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMmgIUGzRSBbnvB58lcb29jfC8Fot+GkoMpP0XE4XIvn0O271/YWwfAhJLuV9vP1D9mz67c3jgpchJUzHGU7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_24,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210071
X-Proofpoint-GUID: OEMuqvhNm_AR0lqTG9UfZfsIqO7MEVdt
X-Proofpoint-ORIG-GUID: OEMuqvhNm_AR0lqTG9UfZfsIqO7MEVdt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/19/22 12:42, Dan Carpenter wrote:
> This code just reads from memory without caring about the data itself.
> However static checkers complain that "tmp" is never properly
> initialized.  Initialize it to zero and change the name to "dummy" to
> show that we don't care about the value stored in it.
> 
> Fixes: c4b6cb884011 ("selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  tools/testing/selftests/vm/hugetlb-madvise.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks Dan!

Your analysis is correct.  We do not care about the value returned, and
just want to trigger a read fault.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> 
> diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
> index 6c6af40f5747..3c9943131881 100644
> --- a/tools/testing/selftests/vm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/vm/hugetlb-madvise.c
> @@ -89,10 +89,11 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
>  
>  void read_fault_pages(void *addr, unsigned long nr_pages)
>  {
> -	unsigned long i, tmp;
> +	unsigned long dummy = 0;
> +	unsigned long i;
>  
>  	for (i = 0; i < nr_pages; i++)
> -		tmp += *((unsigned long *)(addr + (i * huge_page_size)));

When I originally wrote this, something must have complained if written as:

	tmp = *((unsigned long *)(addr + (i * huge_page_size)));

changing to += eliminated that complaint, but caused this one.  Happy
with your changes, but if there is an even better way to write this, I am
happy to change it.

-- 
Mike Kravetz

> +		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
>  }
>  
>  int main(int argc, char **argv)
> -- 
> 2.35.1
> 
