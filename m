Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AF43F656
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 06:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhJ2E6s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 00:58:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46432 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhJ2E6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 00:58:48 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SL9j9h019055;
        Thu, 28 Oct 2021 21:56:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7WKv+h1wxSaUCxaA9eJicyygBodXrDjq2KFHw7hlhow=;
 b=rqTsacRihNzQlh4Zq0TU3QvHvAT4AR6nDuTI1tpM599Ns2qvwl/JggJP2IXvTiLBjiKW
 mKUftPvt9gkbrnCF9wjqJWJRKcbJia7RyrQ3aYR6fGI8KcVueB1HGUOHmfQPSbP1cet2
 3D8+iMYqp+u4TZg0lpWiGJVpKgIb1ZaC/eI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c03hk2aba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 21:56:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 21:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igLFiUqtb7DChJB+DzOVLbR3W2Sp7IQ/lJvfTgsr13f6lZSUl6CFRCyuxSyiwjJWc5IeNQMlRukCf3L/awfTYAUM7CrLq/F5FYFGeJrTboYXLPdXZVCdrCRW86X+nD36dn8oaCKPYUfVhBm7QZnaqoQy6tWgdT3OSPRW3so81rDZGuMwz6CBNwPR1hSc+2WIODo2vVDXyKqxN1gT8prjkf9HPdQnq9tonACTR7YrwhBebKoc++CpF4HdG9boT4Ajy+JnzDfc8VX9mjZ5CeGpe1FOMya8AsjSL51GJSMj+RV8csxakLaZfFuRV6Rbz3u/90Z+OQ2hlKluOlz28zx0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WKv+h1wxSaUCxaA9eJicyygBodXrDjq2KFHw7hlhow=;
 b=EXS4pKr6GKpBl2VeNKa9qc/QVFgwPxO//TnHJx/MWJodZreAjDqX9QrSdttSUYU8erdxPtvSLcSkMVI3IgwLdNsEIBSN1T2llr8FUB8zOgKOti1lGiOJjmaS1+Kt0anM6imnYcg3jZfN6XY1aghxWhz/3HtjuBGbKrhSfMbBx6XbAuHy+2aYf2FdaWVMedl9PHIAyLUVj4FLwI8a1K6eCMpvXePgVGXOz1r/OlLa1SbW9YHEKEIBxmDNfeY+8lamnXhE/JLHwrxS7OTgHsAiLRW+rj2ZoyVFW8Bf5/fYyj0NrUTsvLRywb4mZiVV0K+XSV29IFTNusfNMINkVpQrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4888.namprd15.prod.outlook.com (2603:10b6:806:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 04:56:16 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 04:56:16 +0000
Date:   Thu, 28 Oct 2021 21:56:12 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrea Righi <andrea.righi@canonical.com>
CC:     Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: fix fclose/pclose mismatch
Message-ID: <20211029045612.6cdqkoihrvp7kzhq@kafai-mbp.dhcp.thefacebook.com>
References: <20211026143409.42666-1-andrea.righi@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211026143409.42666-1-andrea.righi@canonical.com>
X-ClientProxiedBy: MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::12) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:ae8b) by MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 04:56:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186b2f2a-410b-44db-0e80-08d99a987061
X-MS-TrafficTypeDiagnostic: SA1PR15MB4888:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4888B6F7995896037E872480D5879@SA1PR15MB4888.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iBMnK47hym0ourucVcS4qKtGOJ+08ussweWhTL0/Seb2nXeEn8mR77NgpWn517i0qwJIzsYIB6Td4vOmy9dQ4zNfjujIxFwjp4I3//mbMjLrKqTH6+SAUE9LREoCFSdzL7eKPq2O8x+mXj6oR7pX4nRXJIxCoEtl0lUFC6wjG8DivQ+R6R+D6qJbjvccTv5OVtDV4f5XZwvkxDRZji50q/dpLuhaE4adYUkuBrB37IQXjLNkbmf9MJj99o6CxUKpKjvcWm7vZVSeMbKOBIJJU5N48UYHlFr7a35C7vHVxE95nQwtY2EcFPTA/61thVSC3RN6BRLzHkYTSnA1+UnCleYnMZ2h5nZkTZCiHi9VV4stRCTcX8BiZ9EkvHyQUNs+lg+sAYeENMDSTLYbfGSUN7YGtdFj4M51xXkkN5oafcnXfs7zYb/1Km94fXBOgjfdhztj6aocoMYI8wkg6zOXrAbuphOxFRh/iomazg/cYd00Wf0FHIhTdqSIWh51AXKuOSHm6SNKdaAyV95DE1KMDr7twZXcaODJ0QczIeTXjnhDo27oh5Ix+fH9cQHlODHyYbY9YwIwIY9IHbZYRnynEb3JtyCKPdG0qqr7tfykkVa/2D8e1Ah1k02QCEiJ4IoxorairOrsT1q7wlPXk/CvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(55016002)(66946007)(66556008)(86362001)(8936002)(66476007)(9686003)(186003)(4326008)(316002)(6506007)(2906002)(7696005)(558084003)(6666004)(8676002)(6916009)(508600001)(83380400001)(52116002)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?djZbwZQuQRJPbv+Uc2hlrsMwBtjmFi2FMuA0O/iVd7qRNgRfvFcUt73dk87L?=
 =?us-ascii?Q?plqkQj9rV6eiR3rz3RUTcX6llMMIbRHJKLu2E5n0sPpLE5S3YqkZwQdI+S6K?=
 =?us-ascii?Q?w+65XLQOSHSykdAJB2aIlpCRDtz1Vsr/Vp17XFCWvJ5APRm7QvfdDJM6WIMM?=
 =?us-ascii?Q?X7hqnowOsjABTbCfZENMXqTmsUvcg7V4rGABr8svNUfFh+s4SW69D5K5JMj7?=
 =?us-ascii?Q?ulHx1Ki7wGdv5MY0BJH2QhNwHxvjCg9TqtbgTiKKnzFJipzq1GX3XD5udDsf?=
 =?us-ascii?Q?BmyW9sqSm0sy8E9zhbS1HuOyEfyveza4Suxiz2uh1M19b6DmxVZC9pGE4A4w?=
 =?us-ascii?Q?d2b1uMVJ/TBh+GfCdPWmIklq6NSrysnzMpl/RbP80mSKqGAzbH1TXT8U0Zdu?=
 =?us-ascii?Q?2oDIycnsP634YNnrG/FMHJc0A/yx8KuUmTa5NqPAMZem8Nn20klzK9+Mlkva?=
 =?us-ascii?Q?sranaJSDHKotoY24195FGgkO/4TuTLVcNyZPAmJ9q4wumQ5qu4cC5fcKK9+M?=
 =?us-ascii?Q?aps9tUr9DQd+4hn6f2l3QhCtFgCKcVanX8s7ePXwMXbqvOyEQkJQtgIEh4IU?=
 =?us-ascii?Q?momkda9z7rt0SS4T9Y0AU77HmPrDn6cQkOLO1XMABsylMdw6yeptVfE/Y5jh?=
 =?us-ascii?Q?d/pUYs7dffkS0KRxV/Injvr0y8hVAEZn075pliP4v8K/r5rw9fG5/2wiUUGD?=
 =?us-ascii?Q?cC15aFTMdLcqxQJe6GGoF1XH+D0+oiihoTLRLAsqfnrym34iJFAsILuxk38V?=
 =?us-ascii?Q?lU2j+Hp2m3Qfw1ImEPmkkUrqspYhrpes8hYTR1x+Kf/5sFcNPe9zXPec/et2?=
 =?us-ascii?Q?6ZzNlV/+nHrTmHNcb9TJapB8b5wBWAl0FiV3SoO1UQbLgguSWQzJzOYxzwUf?=
 =?us-ascii?Q?MGCJvppigBshLmW6h9t7IRGYForUEo9K91wVZGNJ89d0fA5PdEVLpnkUGhHZ?=
 =?us-ascii?Q?OehjFVswOjs9G7FkNB9zIu8j6s+uZL2NJ75ttqnIek02zw8F4mXXExLhnVHn?=
 =?us-ascii?Q?RSG1zcymw+DpuqgI3YxqteCsbxKW4IFvsIDQVBRChCYkDtaI5aDcuXsFUfOy?=
 =?us-ascii?Q?DMnpsMpITpppepaQrUR66rqz6uRuKKBIDwrtMChL3uELLqXFVPc9FjcSyNK6?=
 =?us-ascii?Q?ffY84hIlsM5TQiKjIcSHpNSKqlEOJZSpTEzXModxIEf0/x9GyrtTLcatmXzW?=
 =?us-ascii?Q?4wedIsM71nd+HElJYZDV7jUPsWQ3mN4Sc1J2FRrMWzlkV5WbZukS1sM4tk7r?=
 =?us-ascii?Q?tiZdV17urxS/30qRHp84wPXRW2+BKK33T/m49veTCQjAr+TvpZpdbO4Zlrf8?=
 =?us-ascii?Q?UiCnHA4vm46obpige6V6L51YonVL+q2uRn3ri/kww8hJP8h3k8FDjhCBaL6e?=
 =?us-ascii?Q?onwlAcxrrQ+3iFIa7uTNHIU8Aqx4N5HIPcuJe0QIU/HUpLjjzx6xUFTnFdQp?=
 =?us-ascii?Q?J/RQKM/0MABFVRKJMu18SFpucEz/n2RsNi6TVqTinDao0ALo6bWO9NYWdhB5?=
 =?us-ascii?Q?LDFIdQidT86hctOinB2TTKu7VW9DbAHSqI4Ji+SHvVsLtgtW/oo66C4wOFVu?=
 =?us-ascii?Q?nbIUSa9LgrU0h+UxGrAC/ns1D7xjx4nnQZZyMDHDu8ceAScORbBrNqcYf5F7?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 186b2f2a-410b-44db-0e80-08d99a987061
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:56:16.4186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75ZAObwFVHCF/GdQjS6qE3GlFGOMh/eLgFGTZ3tPIHxMOMxFb153ngeSUzzY63h9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4888
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: OLtVnq9aycvaaF9Eqt_mb9lPM8mhTwye
X-Proofpoint-GUID: OLtVnq9aycvaaF9Eqt_mb9lPM8mhTwye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 mlxlogscore=661 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 04:34:09PM +0200, Andrea Righi wrote:
> Make sure to use pclose() to properly close the pipe opened by popen().
Acked-by: Martin KaFai Lau <kafai@fb.com>
