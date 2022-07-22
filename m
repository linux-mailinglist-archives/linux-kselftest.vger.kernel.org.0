Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA06B57D9D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 07:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGVFu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jul 2022 01:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFu6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jul 2022 01:50:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618D43E71;
        Thu, 21 Jul 2022 22:50:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M1XqNw004156;
        Fri, 22 Jul 2022 05:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=OWJ4yaWNjxPu2ysbgj55qVygT7d6hyH6ePcO7QutRko=;
 b=DCbMT1udvJIsSy18TJXXyJW5txfU2heLoXB233NezQjnn/pCam2cDaj3/H0cnLSRztC0
 E4vRu8brASpuxTZFhJ36Uw5Gdp0cXvdLvuo3JOxN7oOUZp80K4GbxRDUzNdmKfPSCMWo
 lWxy5O6/d8gezEUv8Yf8jZzJ5jCu0hFkBF0e7HNRzUWBvV3OtZjPLdbctyqcOYOYUmX+
 h3HTrOoOUHtXc8825WYH+FkdnLuxlxlMYqLgjsb3EQn9RZUY/HDf1MdJFHOsOQoyomPl
 twiUL/cAFT6A1/9HHLM6Xc3h6gNbEVlXRjcpD2FHmYCzUi0e2DoecneZfU/EJez4UvGr Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtpg28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 05:50:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26M4U6cW039198;
        Fri, 22 Jul 2022 05:50:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k7gynq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 05:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWi2CUAWcfHpWX+fUjx4qiWezRQzGNoTpwoTXp4ujxoRRQZ3hrLzcH1pYLFP/imC31lgQ2qCwAacspkZxBOToRwLNcygIlU2JlDYEwVNs5c7qbK19oB3MR/59hs8zy5FhaZVcD6tfCSJEeqrElMLWnkxA1G54NSpsm0/U6evlS00Mv4UjcI8M5D/UNIK4INEnn3jX3ipB/2m3PrdYGDbPi7x9WavFXluY42ECJIRXh2MlyILLHAxlCBmEhZ0X2v9N62YHO7rrcVYNPPonJRc7rJPrW7GVC/18otFvFg/oRxyk2eAzr6Yfk0vFVdJjSE7DqPl1euZnfLmc2Yq2MDdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWJ4yaWNjxPu2ysbgj55qVygT7d6hyH6ePcO7QutRko=;
 b=Jw0zs/JAhxB2xNK5UCvDw8tSRgCShzRTOVi0hJK0jDyqGwOSinz/mNAcrmD0kT3yLFrsU0ZOObZ61CmEoWTBlQaV1iGF92it9praA/r9USLv5C6I2lN3eEAA41TcCbNQZkX7TkvId8s1qo0gguC3Qwo6ztYmz80H9VWYJllGCt78Vo5PtWkSUW+WgVKXNffG+qbVVFmSJEmOzDnuZEYFqb6xxwqsR0/Wg4meE5oF95mkeusuSK3bdj4Te+/fC5CVyLn4KaFCCTpGgm/gxcLbE/SmD5179YUbdcdAM/Kdby6Yv6Yl9n0RgJ7pOSQsfBxw2Guaw5YdUWrCFv9+d9gQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWJ4yaWNjxPu2ysbgj55qVygT7d6hyH6ePcO7QutRko=;
 b=cBSNHMnxeAJy6kU9JiS8s6FQ/h8aD+LPum8T+OITW5xIIij5rxeaBVN/ohYt/S8Mf0fT/Gtoqi6zIRojmzossBn75DbWKOykWHAWRjeqf/6n1F0yJG5WPgxrCl1qY2/euPBCMIuq1Bvbhryl0lT9gl7jmp9BiE5cv5WvEkPyoi0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2408.namprd10.prod.outlook.com
 (2603:10b6:910:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 22 Jul
 2022 05:50:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 05:50:48 +0000
Date:   Fri, 22 Jul 2022 08:50:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] selftests/vm: silence uninitialized variable warning
Message-ID: <20220722055035.GM2338@kadam>
References: <YtZ8mKJmktA2GaHB@kili>
 <YtmSdjr4oMW+mVax@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtmSdjr4oMW+mVax@monkey>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0154.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bce812f-4ff4-4015-98d4-08da6ba61ffc
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2408:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHGdMs1dSVp82ulyxGUOv3IA4bufUZRfg+HNHemM9Rr7vBi5wQj7AL7RSo3uH/65Gfwjg0c6B3fxoD9u34w1LB7kDx4EtvrbTYg446VSAFdNZVI0UK/bOP188KN7FNuQO2tpnVNlmshleUr1vxgkl6l86Av9INKkiOLdo0eJJ2aer9kikrdKC5B/cvZ/1acO1V3IRuBQTXj2ta5WJb7TbPeyIrgK8Ei4+Is2cfpYBmrGSB2X5EEqGL7X3y/AdFA5hblV0tLxmQqSkO5dAwhr4ceC4WhGKSngutMwZcmNW1SYiqps8Jr4vq2ujS2LB8aBzQhSfI5gpoUKnbZ8UCS4JdmUMLAUA3v/HmJbTvglZTu4NkuujVn8A1qbT5QGOODArzr7Y/8bk1Xw0Z7A3UIcYKi90SwgVgcZIZzaCBJX/WVsyHt26fmj+3BGu3do5KlU+q86rB1R9ei8l7+dE025Gy/XzhGIMZEhvAjhYoswFLs64zBewD1WG9Bxn0c8e+DSJ6si2/LKhKM/sRObFR8qfcD8izhjwr+vwv1tlMpLcgZpK/D2TwW48D/OoewRrI7g7tTVzJQsxQTCgTaajppTmq0zUNvX3yv3FAw9opdInDjf6bH4Y9zKkJzIdTuVyZma0xFzQVVyr+YL5m/zs5O2Qvq5qxHSAQMWrwAs4cqXBTFT2SlNkpUgG4ilqVOt+GEvb/5ai84Lnsqf2fkuo1/asatxNwWvaA9WUVQjSEflG2yzeXxE4GIKLw80ZCpRALDCV07fw0CoiopusWJIOJ3A0QPVaRh5zJcjciI9S9EEz+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(39860400002)(366004)(396003)(6862004)(44832011)(5660300002)(8936002)(66946007)(66476007)(66556008)(4326008)(8676002)(6512007)(38100700002)(26005)(6666004)(33716001)(2906002)(38350700002)(33656002)(86362001)(6486002)(478600001)(6636002)(54906003)(316002)(1076003)(186003)(9686003)(41300700001)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y2G89CsTz0nGCQapw/Y/BQeUZNtBV/JkrHsX3FHIK8jSB1R7zX/H0j1Vtjo1?=
 =?us-ascii?Q?4QfPNbv5j4QTpN+eQOjpKslaQuip0YK3wVJugztUWbDlO2EFVwyiYLJ0zZ3n?=
 =?us-ascii?Q?P1LO+RHBPfpaQO3G/yswvpUl+q7q+Aj98lvtck5R5cdw2vYH/q0mWFf1nx0t?=
 =?us-ascii?Q?ZlWJ3fKIyDmMoDuGQC8u96r8FSRGe0QFnhQvHaas0GRVk3PWXskWEO08GL/z?=
 =?us-ascii?Q?ba8/inSpr9ncAq/DGo1I2D5c+eEaeCWT2JxSZ8uOP5yu5VRBEtTGqa2fR+F2?=
 =?us-ascii?Q?w9rZObalNTO5QUzBp9QSBOr3NoHLtSl6rNTNpyytJektVXmGzLPT9hoaelnm?=
 =?us-ascii?Q?n28GiW/lZyg2a+sgYqargHKxuKEeqGZ6exxPXM3Y/gEFUe6ZFk5CRbphisT2?=
 =?us-ascii?Q?nxymQh5PyEd091ZCSkSF+woyYdUma4V7l9KE5RQTZ98dS+Nv5+46E09aaifZ?=
 =?us-ascii?Q?pmuf77T9KMRy/yLad5g+o2yENGhB/G8LkjecSTmkZqxQ+hHQQfJwgtwnIWfS?=
 =?us-ascii?Q?kjedjWX7FBkBPSyu07/06GnSrhuMQ+zyN326DnqWyMfdYN250l2Jf/vcII8c?=
 =?us-ascii?Q?G9DB2tbQfrLCpLTwTvXv09ygX4YRFTlergU21skcbmzy6H+n+fX1PgfrOneF?=
 =?us-ascii?Q?GxwTKzSHDHDqUjmPW68gEiPUqz8U9trv/3R8sU1c7s31TW4x6scpopL1iwvo?=
 =?us-ascii?Q?wIdF4DISO8IrnZp5v0RYmshBx58sESW+r9IgA5cg/rSxQEn4pEEseCz6uYXe?=
 =?us-ascii?Q?eWkU6m91cX73NBojnOQ40gfACrI/7Mku8zjdjmIlGavDN3cBp+DXPumKir8r?=
 =?us-ascii?Q?WGudP1858v6PK4U+b3wMTyohzr8IPlGc5G+MRgMhI/AvWJmaPUqOd5bfuWtg?=
 =?us-ascii?Q?6h52sDk0gcnu2maE3JRKYWqfQm2wIjzMvJBEUrVmiv3yzHX90Tei1+Ogb4ul?=
 =?us-ascii?Q?8vVfSUKxUOw8W4JORNsDtrsmwMsZTfisLRfRcAEh26VZAa8JZzthrHlSpGWv?=
 =?us-ascii?Q?Ds7xo/XV+nltc412Mu9fXEZ6ettSwGj4bGnHdeWZp7MLjKqE3kre8q08fwBT?=
 =?us-ascii?Q?XMZ328YM/PffgneFyF1cypO08t1pz6FeOeWYPFL7UjUY00l2VzHwdYkHdNxg?=
 =?us-ascii?Q?TvjHL1ytAAeTdBD55o1pwMXw0XTe1BI59ukofb/LEYEG0Cz8fDhsi3niuqOj?=
 =?us-ascii?Q?oqrqmfJPaSr9ev1cD5PcnOutHnkoNjxX41fzOdoPH2u+3fgXTMJZE0wVlApw?=
 =?us-ascii?Q?eEk2SG3AlC7z8mgO3TRpLyU4c1R07vW5PrEo8Pb7IeEdSE3N0EbkKvR5sX+K?=
 =?us-ascii?Q?td0igzphkr1KiX6mv2W/v6JMisYkX0fBTZE1+Q670cLzMXsT4BfRHaXgIbdM?=
 =?us-ascii?Q?L/awrgA89t0OVnIoH4IHG2WKOGsqUzNPISTupYziiyx2mCz6PjD4iXnAis6t?=
 =?us-ascii?Q?D9HPajZzZDIqHREITG0AnyHhVx4s49aKMGZ4YVR9dPwiIwefEcl882lPp7Ed?=
 =?us-ascii?Q?YSEiI9orQ6AUoVr1wnUpwW8m88oCqXQ/Ue1Vb0+72uyM+R/U+dxstvzOgqcI?=
 =?us-ascii?Q?2g3exip+iZijLVrwO6KjMQuYKZ7SONb6cVMNr0mWeb8G0Ewt72Z+XOGtsU2r?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bce812f-4ff4-4015-98d4-08da6ba61ffc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 05:50:47.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMIOh5OUjq1Lc6UxtUfemwGnJTuuPFZ/TwFkvpJHekgPJhdb2bTGMipPzLmHPLESgupiaxYX1584+BG+VJDpzGcAk4crgNFzntELoMuwUiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=767 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220023
X-Proofpoint-GUID: ox20pF8rq2vSyWIPhZcSYJApDno_YI1E
X-Proofpoint-ORIG-GUID: ox20pF8rq2vSyWIPhZcSYJApDno_YI1E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 21, 2022 at 10:52:54AM -0700, Mike Kravetz wrote:
> > diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
> > index 6c6af40f5747..3c9943131881 100644
> > --- a/tools/testing/selftests/vm/hugetlb-madvise.c
> > +++ b/tools/testing/selftests/vm/hugetlb-madvise.c
> > @@ -89,10 +89,11 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
> >  
> >  void read_fault_pages(void *addr, unsigned long nr_pages)
> >  {
> > -	unsigned long i, tmp;
> > +	unsigned long dummy = 0;
> > +	unsigned long i;
> >  
> >  	for (i = 0; i < nr_pages; i++)
> > -		tmp += *((unsigned long *)(addr + (i * huge_page_size)));
> 
> When I originally wrote this, something must have complained if written as:
> 
> 	tmp = *((unsigned long *)(addr + (i * huge_page_size)));
> 
> changing to += eliminated that complaint, but caused this one.  Happy
> with your changes, but if there is an even better way to write this, I am
> happy to change it.

These days compilers don't like when you read something and then don't
use it.  It's possible they might just start optimizing parts of that
away?  I think we've now tricked the compiler into doing what we want.

regards,
dan carpenter

