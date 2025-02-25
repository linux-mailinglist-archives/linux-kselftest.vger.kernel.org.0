Return-Path: <linux-kselftest+bounces-27476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD3DA446B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774FA8800A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274418C93C;
	Tue, 25 Feb 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n/dACkRc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N/Nbyb5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897321ABA6;
	Tue, 25 Feb 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501488; cv=fail; b=idzVM7KwQcR73KW9AGO7ZnEOZlBouKCeRo9b0Dd+vCZh9KkW6eYVcwc9tXNB7H/LXWRlVax2lKONf/uoFe0VjQzrC5OFu/SpAZLbXs9JtJ0Zm7x9w16QPZS7BMGMFeIWbtLIrcLT/FTM84+UQzRThDuuA6Kh3DuUc3/I3Lnq1y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501488; c=relaxed/simple;
	bh=37rqSDHhfibeL4ET0L1exbfHjKWCiHAPKRWCyEa5gn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ev1Tn98j/v2G96xZ9hZrfK36FHNMFrJnhoqAFT50GahIBIG+lQNBPmOhjUrKgNOriRN7TL8BTsRDUiFsN+XB7J1P2+GP5qYByRrbpw/Pytj0/xb7v2nhmr40MUDzqqs9Q0Mcv/PCn1APsFxc3xnYsx3fMfXGNjns67VEtwW/fQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n/dACkRc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N/Nbyb5i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMjgL028812;
	Tue, 25 Feb 2025 16:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=649r4NkocGSroZLlcp
	ntxdEwac1v/7ZUEQkfSZnRayA=; b=n/dACkRcccjkWzwdWlnTjX4KcJkDQxpfoO
	vsblIlStnEIFTdQabWLeaPcHsINuUqifLGWsWIw2tTmGP6yezEfdRZRHxM57x4v4
	VUx7SVODtYuc+oJK1T4BF+fqhnfrr2RJGGaG68Am0r40YhRwPKO9nrVMElUcvbc5
	fltLgVSDWdhdFt32VdfbxVPt3rlQl0YZ/in8mS0XlVpTiVD52EZ1QRTPL1EGtVAj
	mR2fITFLkkIufWissTObWIfQlYsUj1hKB9NDom2tTHySq+CCzrDLub5zQjjVp48V
	rTBmjmFEUT3S8465ZcuyNjOqsuO9B69Vvuhe/A1Q8TggT7P8ewSw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t5qks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:37:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFjhKb012668;
	Tue, 25 Feb 2025 16:37:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51aqxmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKahcG/lv/Nv5I6PkNvm4MmXxppweUc3szhARZd1e/o/Sk2PPoSxE2TXMgmXpBEEDT0GSXlOxiBAmucHisFYXWgfn+V534iwrI/AxduC2OoQaD7yHNK7i6XlwHjo70kJVqHRVezpAoQcG1HIKu6YU8Bnu5fXVjRlSPpBOj/GQsxC14q/q1GPUG9BhP4LWCFMDYaQJwk5m4jZ+a5u8Mv6pzHYy7jS0s+Qro+BaJeeWhaKAooKmkmZwU1Y+SGGdd2spIIo06Mn2OPbJwlcJ1d4CQul03eStkBHC4lMR4A0qOUDX1g8KIkUvPLCygK7VCeunIymkVXwO7Mp/a384WcnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=649r4NkocGSroZLlcpntxdEwac1v/7ZUEQkfSZnRayA=;
 b=GwhrA9t3ien9InFa5jBBfru8dd/TzSNIRfdDgkYZ4M9wpJ4dUzYX1IaZ0nPwzhRaSf6whAzDkzpIg82vtDdEfwNtt4lW4khZep7IGIllaL3SfY6XHltfwYyUGSfXv4G6O1j++HNRrJ5+9amYpiLfMm2dwKEv5cx6gezNZ2dn1rDKkfTZo9uE6mt7ihwmSIOBj8yyHw3O4ea2cG9ryF2mxjiUladNR5yMwTI0ApHl2KUaMMRhcVDLh4nUL7FL8Wu/o/rC9Bi7gAcK6Eu7KoXf+9pBZNAg0FO1UI84pFg8rqcNiz5LfHUahGPRO6zL1TY763ldsI3pJ296VyFx97dR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=649r4NkocGSroZLlcpntxdEwac1v/7ZUEQkfSZnRayA=;
 b=N/Nbyb5i03zUUmNf6MYhprDpjzEhZVdCGx55fx2lg2VU0rXlr8gzBQvc9rrfSRrQ+dDFGUhL3fyST0uKoUgOeVOOWnJrFg/eSykUMgc2gEYP5KnTTr1vmlQu5qzYxf34NfPYrIae7IltM5AJjCwa6mSl+3gQZzfujS4uNJ0CKjY=
Received: from BN8PR10MB4099.namprd10.prod.outlook.com (2603:10b6:408:b7::32)
 by DS7PR10MB4880.namprd10.prod.outlook.com (2603:10b6:5:3ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 16:37:42 +0000
Received: from BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d]) by BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:37:42 +0000
Date: Tue, 25 Feb 2025 16:37:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <3102ab3b-67b6-4047-9db7-e83c3b9c1c53@lucifer.local>
References: <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
 <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
 <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
 <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
 <e0954e13-2c7d-447c-ba86-19875c74bc3b@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0954e13-2c7d-447c-ba86-19875c74bc3b@suse.cz>
X-ClientProxiedBy: LO4P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::12) To BN8PR10MB4099.namprd10.prod.outlook.com
 (2603:10b6:408:b7::32)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB4099:EE_|DS7PR10MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: 346e50a1-76e9-49ca-2d79-08dd55bab9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dD8wiQyfyuVzPe9U5T1QiDGJLg9TDvXdXFusBmsbf6zDxe5LZibqZe5loCUy?=
 =?us-ascii?Q?2kdkP8yZ4ILXVJ4OKu/UtsL0Ze6PmrVTUVRtt+qsi/I/y5sJCaDCXL+GGITV?=
 =?us-ascii?Q?Lz3Hvbcs1Pyt2li4aRcQ2jQ0yzB+2YTuYV09LcdbgQG0ggxP16r08iXG0feC?=
 =?us-ascii?Q?d2Q2+2hLi8PG3DZcZNtgzPD4A/lHumtZevWfpKxe93phJqI+1O9VPHiPYc8r?=
 =?us-ascii?Q?3z1gH0wUjWucNPPKcRjfZyQeNqerR8qsdkC6YFMDp/YJ2JXHGoXuOnaWz7JN?=
 =?us-ascii?Q?FDdQBl3eFSElYbk1qcGrpm7S4yNLlDtmSHGAhinLmW3Z0qJhU7Q4jDLfnCa2?=
 =?us-ascii?Q?3n/rrndmSaqe+c8YyP4GGizQdo+GWXC9HKGXrVfaaiJvjtEOaT+pj7MPoICr?=
 =?us-ascii?Q?nIUSLoEvOSxjJGDZH4Zp6XsbeVUU7xu1Cab7lc3NzZkj7pNj4Q4irDVpCOx/?=
 =?us-ascii?Q?KyzmiRapLAnS7rKftMxJQU8g1DfAAg7cYv+qcer3DIPhaQhsOgpYKMXB+BRw?=
 =?us-ascii?Q?L+6Ut0eQAnpB7HJFi70JT5yWf73hLV2G2p4tE5hHpS1H+VYNCHSPFbCa9Z55?=
 =?us-ascii?Q?hjM4yvKZZxqxmcMyZdaVRbxjh4K/PSfqKGxh3gzwWyudHH/KSET2xNYGJqVT?=
 =?us-ascii?Q?Cy/GUZ7o0daI2f7Myw0K2lJtMYjcDeRbkn4kZZibf9zSx6IzuT2hPr5jpO+S?=
 =?us-ascii?Q?nehL78G5aqQjq60qpFfZamMiogiI5m7ZQMY3lNFA82oTrw0r5x9RlHBE/HE4?=
 =?us-ascii?Q?zWEg+rudW7KWeqKCS07Z7KVVbgZQ2SrXfX8mQBHHYXSzQ+jOnJyuF2hxEwc+?=
 =?us-ascii?Q?BbHq/qh7feQHBh+ZNUxbbhsBk6HQxlGlYTtWU5axfS+HJiMlkEHsD4G0S8Y1?=
 =?us-ascii?Q?ExVhLzFmf8QNITsyQ43Pv4ed46V+Vofdx9fMJbXc4FwRLIImlIzVBK0g58sL?=
 =?us-ascii?Q?OlrXXD39Kd0S690oy7+E9G7JYdqCh0cE7nOfJi2MxoP8AF6i0MFqyQSeqpWb?=
 =?us-ascii?Q?kOxXVU+2/arJoS6msX1yLrxY3ym3DBkLbvOci7KBmiGvQqaZ7LTsEbpK1bIK?=
 =?us-ascii?Q?DmedRtR1+LL1Mg1+rxleFdr4B6AMAjQ/aCMIrTOcwqiIVkVy8VbjS7H/1se0?=
 =?us-ascii?Q?H98/fCe4hBiMsKJIpQx0XZ2JVQAt/fkz0XBx76k5nTnJ84P3022DeAHE169G?=
 =?us-ascii?Q?bjWLPd1Kzn4isbTwqMXuZrnX0Zm2WSjkCRaDoR0MD0sB450FhrLM74mnunmP?=
 =?us-ascii?Q?57e4xDGLHeFDfZLNE900f8yVmgKhGEcKyVRvFVjoZt6VrvkarJUT7SbcaSJh?=
 =?us-ascii?Q?T7qe15uZJrwqd20ZhwXPmqJHfdiaFNOywnPSOtHyG97wOwQgGrDRa4mjD+p8?=
 =?us-ascii?Q?3YJaIdTg1pFU9mBS/dqjUT9XfbWd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB4099.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Amv8LNJU2XVmO7evRt1uaOFOHhbO7cjaRVDmnI2KC+Eb7NwngD2mt6FCffRB?=
 =?us-ascii?Q?P3ucAANWQITLsI2LNv9Gf6o3hIZ7HFy++7gZc1hEAgL8CThCaknmE4tfwbt/?=
 =?us-ascii?Q?KjnN7TA+1IMx5uZefJsnKPwdW56RAQvGv4TIUiZNaweOt8FSdLHqJEh45xQ2?=
 =?us-ascii?Q?zNxQZ6ItkhPxSY8o9l7JqGnw3u02KhltJ0qibiQ9bBuxv/1yH0+UzF9l7uJq?=
 =?us-ascii?Q?O/Kag65UMca2Jmh5oMeYpZuoD54dA2vAQtSl4iZGFpu2aYxPiCp9l1Rd50gy?=
 =?us-ascii?Q?z9zoE5mlng8mgvlGf/+besorQ0IZVp2t+TCvh4xlfBk1NalcmkRWPDuWlQl8?=
 =?us-ascii?Q?A9GBPoZeYXUFAKW7xioaeHeh6g1GomqwknY0DknTYPTwFURUIB1tfTsdOsqP?=
 =?us-ascii?Q?qMEHN1howrdhYSoRUtuBKQV9iza4kb/J/GkiFxpNt6NlfwckkSbMgtr2j5cY?=
 =?us-ascii?Q?0mOpLqWjPIQ0MvaPJUS7BEt/4b4Hoq3qSMR2wc8JzvPaN1lSlEttzmvahxP2?=
 =?us-ascii?Q?4cbwDxfdmIVDJjqVJfQu5QniHN9gTDc+r4MxHI6SiwyowOvRP39u08WVW1l3?=
 =?us-ascii?Q?Lbi/SwA4ui8sFipNpYhDLQ1X1zhfzjk9rLW0fyEynJ3EC8j/OsP/YnBa6IO0?=
 =?us-ascii?Q?vjFbAj+VNa+W1KLoa+60LyKtJySoOdevO4FxXXrV9dA7lHykvM71Ty/HhLWN?=
 =?us-ascii?Q?zkj6EXK6VSkEHecxFfdIMv1R6TVtIlh8JAp1KKLI0CRgulHZ6m5U7mi5/eS6?=
 =?us-ascii?Q?qlTKt0WWNffyuTE1HDT00OmJAhMoBl0bRIW5Aly5OwbnoZwbUFSvB2NSxOk5?=
 =?us-ascii?Q?ZD+/KwjiQBvA4N+aS4CsLjoUOY8W3FAxq82BF9+Vvzikzbc+BT0Ed8bvEMNA?=
 =?us-ascii?Q?lpgSfMhfd0KoYBaDT+YCwatLbcrOUtKiGG6JOU8BT93Mpr/8LzIylNBvBHWC?=
 =?us-ascii?Q?H+e9ChnJ5lb8yW6hO3ijAB/n09MD2UgED5ArE9GCe3VOP2jqTKzySvCZfkm1?=
 =?us-ascii?Q?fyOMvmQCn6QDGHHnZVTnXnuDgw7QuqdRWEpxVpGB/LAQ0WkqCnaFE4dqP99O?=
 =?us-ascii?Q?nE6lxsmoY/tNAnkKWj8NliUNubtgm2HzzXybLdhvhB4NKbopOoSE679UweYz?=
 =?us-ascii?Q?jU3PaAMUDFaDRC0SRVw/S8YvgP3+9MtWEY/kMND996V86FzZ6s01Eq+KIqfX?=
 =?us-ascii?Q?qT2fGxSHUjIFokUynr+ifEtDqlBcFEbYl6BdZOtNZfRDQ4q6Tt95mcQlginb?=
 =?us-ascii?Q?bQDyYeq8zZ8c0KUwZ5fwm+S6cvAAmuhR8OyDnMXugl8H7iRAWL5RUqkIpWxe?=
 =?us-ascii?Q?xyr/ZeIh01RvnxQdnQtX6Qzr1itaA9WuOqVU/hEpePJm1i4f7D5PHvrYKE4o?=
 =?us-ascii?Q?VHCvamzk98yVN4MNR/S9nI5y7rjNYhVn+QnNdp71A8KzIyyjlFSGyV/5cO7o?=
 =?us-ascii?Q?kK/unRP60E8y33pUew2uaG08v2b2LTXwfgJ3D+UfV3KNSttTd60abqWb9SIG?=
 =?us-ascii?Q?hhnGnGcvcYcUjsS56rgEIA6FeJNFyzEZeLPV+JE/t5vsn0Ri965mxjLac9Et?=
 =?us-ascii?Q?ohaegNcu2fvrvyR4RXECAoJDXArSdoGqLLCWZsmTzvMRUf0cqBWVh6xLatSO?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ycBxXrVLAGnTtbnYwGOkWVdgGPDGDJfhZu3rqHxzAURsTP8BRSHQ2tpE5e8l//qcSkiswFJRG+Sz8uoa58+vBGA5mkmHJTadq/xiLBVqcy7SmWskEzdYuC2m0+UCG8hS3uKLK3ZyhHsjpQPIh8ZPp/XKUqVlQg0rOHO3W35B2dbQi+mf8yFbCRnITKTq+12UoE7HiCymTxNjgquVJMDhk0CW2x2Y2jI8wrUS7YdrpXLghOikiG09foDYb3D2ZXaNCYhkXNSRpBNtRPSpubUEQlXZu0R9LtCoT7XY+pfPU9/arjC3weblD15ghbkqlDMV1ePLQIa0BbQPI8JFxhiFlW4auZ7BWc107UTRf4co0K6tDKK+4Zl/3rHfIuCkLYXhSP7twP22itviIFRzCo2eRTQM8iva7UdPi0TMo0NgVP85o1U8IMtSTprcfW/3N6x1YnZCbK3CQrn/ZgiXiyFij7WySO6dW0kRL1esV/4Ulolt/Lp0yir9M8h0PjRX8T2FyzoogLvaATtIZVE+GQ/ahJop+fPiqBRT8GrGzNpp0usUpOT8ojRxMqIhR9EdoNRNoLvOdSkOyIv15Yt0l1HrxKZo4HNrwjvhk8RKx83x4Lc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346e50a1-76e9-49ca-2d79-08dd55bab9ba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB4099.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:37:42.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cq2pRE0gezzT2asJ++MPpYLfkY00B/fGFxoUYETmcMdckEfks/VGRXQ0ufDYFabyxkH+iHoGgCPQpLg8KqDnGiLU9yT1LdmAS1t7+jWcac4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250106
X-Proofpoint-GUID: IapFwdqDjYftnX0Vz31OLFNNKo5cQmUj
X-Proofpoint-ORIG-GUID: IapFwdqDjYftnX0Vz31OLFNNKo5cQmUj

On Tue, Feb 25, 2025 at 04:54:22PM +0100, Vlastimil Babka wrote:
> On 2/18/25 18:28, Lorenzo Stoakes wrote:
> > On Tue, Feb 18, 2025 at 06:25:35PM +0100, David Hildenbrand wrote:
> >>
> >> > > >
> >> > > > It fails because it tries to 'touch' the memory, but 'touching' guard
> >> > > > region memory causes a segfault. This kind of breaks the idea of
> >> > > > mlock()'ing guard regions.
> >> > > >
> >> > > > I think adding workarounds to make this possible in any way is not really
> >> > > > worth it (and would probably be pretty gross).
> >> > > >
> >> > > > We already document that 'mlock()ing lightweight guard regions will fail'
> >> > > > as per man page so this is all in line with that.
> >> > >
> >> > > Right, and I claim that supporting VM_LOCKONFAULT might likely be as easy as
> >> > > allowing install/remove of guard regions when that flag is set.
> >> >
> >> > We already allow this flag! VM_LOCKED and VM_HUGETLB are the only flags we
> >> > disallow.
> >>
> >>
> >> See mlock2();
> >>
> >> SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
> >> {
> >> 	vm_flags_t vm_flags = VM_LOCKED;
> >>
> >> 	if (flags & ~MLOCK_ONFAULT)
> >> 		return -EINVAL;
> >>
> >> 	if (flags & MLOCK_ONFAULT)
> >> 		vm_flags |= VM_LOCKONFAULT;
> >>
> >> 	return do_mlock(start, len, vm_flags);
> >> }
> >>
> >>
> >> VM_LOCKONFAULT always as VM_LOCKED set as well.
> >
> > OK cool, that makes sense.
> >
> > As with much kernel stuff, I knew this in the past. Then I forgot. Then I knew
> > again, then... :P if only somebody would write it down in a book...
> >
> > Yeah then that makes sense to check explicitly for (VM_LOCKED | VM_LOCKONFAULT)
> > in any MADV_GUARD_INSTALL_LOCKED variant as obviously this would be passively
> > excluded right now.
>
> Sorry for the late reply. So AFAIU from your conversations, guards can't be
> compatible with VM_LOCKED, which means e.g. any attempts of glibc to use
> guards for stacks will soon discover that mlockall() users exist and are
> broken by this, and the attempts will fail? That's a bummer.
>

Yeah damn, this pushes up the priority on this.

Yeah unfortunately we cannot support this with guard regions being installed
_after_ the mlockall() but can for before.

Let me write this on my eternal whiteboard of doom (TM), because that ups the
priority on this. I want to have a good think and see if it might after all be
possible to find a way to make things work here for sake of this case.

This thing is already shipped now, so it is inevitably going to be an add-on.

I will try some experiments when I get a sec.

Thanks very much for bringing this point up! This is pretty key.

> As for compatibility with VM_LOCKONFAULT, do we need a new
> MADV_GUARD_INSTALL_LOCKED or can we say MADV_GUARD_INSTALL is new enough
> that it can be just retrofitted (like you retrofit file backed mappings)?
> AFAIU the only risk would be breaking somebody that already relies on a
> failure for VM_LOCKONFAULT, and it's unlikely there's such a somebody now.
>
>

Hmm yeah I suppose. I guess just to be consistent with the other _LOCKED
variants? (which seem to be... undocumented at least in man pages :P, and yes I
realise this is me semi-volunteering to do that obviously...).

But on the other hand, we could also expand this if you and I see also Dave feel
this makes sense and wouldn't be confusing.

Agreed entirely that it'd be very very odd for a user to rely on that so I think
we'll be fine.

I shall return to this topic later, in the form of a series, probably!

Cheers!

