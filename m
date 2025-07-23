Return-Path: <linux-kselftest+bounces-37872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F30F8B0F030
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 12:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25A71C800D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DB528466F;
	Wed, 23 Jul 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aEgNWsEo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EksR6U5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6A253F39;
	Wed, 23 Jul 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267540; cv=fail; b=rQBzp0GnGoLTCh2CyPEskc32f9L3y2Vmsw9/Q9JFOXrBTBh9Jh6dkvRJu+rn5L+RY+0s7qaj3jsbBsdf02glwSx6L9POM0LUs8+uySc64xfY2GZlQ4OCNwfaE3yG2FpsbGTeJhY8H0SQF3TCROOBC4hVy9ih/tIzWA7tULfvUI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267540; c=relaxed/simple;
	bh=0XP5lrqU0CeFG+ViEG9xuf+KSOBb7tQOfE3TsC7S3uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C3aPrH31peZyJiFBhwtd7LMGvC7mEv+TrbdN0+WV8GkStGS/SaoKe61GEetbOreccXevSLD+5vepzBJbY4vJGXcn5Cf/FkyeKJXVZTWe7nTdgLfG6AuN2Udbz5a3z2duiAvNTrRq4B+PPobmMNaeZ2vCWUV0TMty5k71LNkrI5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aEgNWsEo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EksR6U5P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8MrHU023827;
	Wed, 23 Jul 2025 10:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=87JKxGzuH/NeFarLNU
	LnUNSqOQuiHhxIYvSTRRHeec8=; b=aEgNWsEoqrOJD9Pn0z3HjPbs21e6eyUuZi
	NC0HJ8SaOOY6dTrU5j2vgzwc/41dKPKXjmQh3pMNaCUdGxf1UKmgBi/+eAJGz6AI
	sF1NAYqxPTYYLmzlGVYurBXSNe/bgvvF1fS/WpOe8TBO1NBa6jXQT2ZJN7FH9Hpv
	oQcZeK+aLN9DcLPoj9Y35FCnmjDQsrmixv+yB4t0R4OVmdUdcrGtdLwIio/cf1se
	866RWI0jpa4hyekMM+rzZaeKs5DM4MjjXfbDUtO4zeeMJNbWZFetBuY/6rlLvwbM
	q9RrdplSrfMX3ZpRkh6t/VBRJK6pkI9tHFpbIKEhIZ28B6AZRy/Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2f7wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 10:45:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9DPM8010263;
	Wed, 23 Jul 2025 10:45:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801taeknj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 10:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wG1oqB4tNc6bZInJKe6XS1r8Z7um1M0lWWm/HOZ/LEB82VjI+CikbxjjFTKfjBJWZKqOOkkMaqVxSIixeumo6fIbJOZGTMOXeV/LCtFiA9mqEshq/ua3ZAAopyUYsAEBDoCpN03vr7FbLyNXfOM/5BbawCqRDWWC4YPrC/sRBhEAeavjFclSOvA8TC7+wIxFGAFGxJ3z5xamcHlK5Dmx/sjp8OQKZ7E5s4JQfdXCdcouy8GKQVHfvnmgx4eG71g/mY+Z5coxga5Gjg2FScofk6n1CEqsxJbN6WO7w1t/yvL6c5GPjKV/Dc86SsrnojK1tU7BMVH6jhJeNaX4bOsvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87JKxGzuH/NeFarLNULnUNSqOQuiHhxIYvSTRRHeec8=;
 b=XVMIlKrsmjon/CwguvRM0g4oM/1QGGIjaAh4YNf3LkeCHLedWNYayfxSCTZ35Bk9gQanJEuLf1lUbDCMRbullIt8aho1m7hBzAl6v9Jh/s0LLnEvvAGYoKXk6ejzMTx7uc49gGg5zXVQ5YhB3P+KnzEVz6HxABVcPm4NL3SwgD0LTaTCuMG/vx3RhSij+DQ49YtbqBfkEosS1IUZ4WHqk//at4wrLgzhjWgLyXR5eZR93Sb2cQ+4sjZPwdfdUE3s7kDFY0Uti/7TiDcXMqAqCRmHyd0kfLpaC6jNpMD2u7OO5Lr43zgItL5SYUw+E0P3lLsFZ/d987mD3xAh8eJWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87JKxGzuH/NeFarLNULnUNSqOQuiHhxIYvSTRRHeec8=;
 b=EksR6U5PNA9n0wD5fUGzhUMg3NQqVzyJQuvE3d02hGMLhIljFO/26U/TPu5yu97XQ8+UV08d6n4NFSuGSzq0Bz78zK+PYhBW1aeXx5CZRwJU1NzsX/I6V7jetUStm53AG2K237r+atjlP/aIOBxkK5ghkMZm+AKGr5XZWfC0I+0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF1EC0B6C27.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::793) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 10:45:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 10:45:24 +0000
Date: Wed, 23 Jul 2025 11:45:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tools/testing/selftests: Fix spelling mistake
 "unnmap" -> "unmap"
Message-ID: <d856925c-90f5-44cd-bdb2-aef5c8224e17@lucifer.local>
References: <20250723095027.3999094-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723095027.3999094-1-colin.i.king@gmail.com>
X-ClientProxiedBy: LO6P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF1EC0B6C27:EE_
X-MS-Office365-Filtering-Correlation-Id: 600fac7b-c9e2-4d7e-2ad6-08ddc9d607be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBgffrtiB0knuBWuyiCAG3UG1QDODZXY8/6Q7VOkL1BQoJlGiuhn5xYvG0pe?=
 =?us-ascii?Q?OV7Ff3rtRgrAvZWFga7a1vxdVqXk+/bfVgmAT6qxOQPRDDAu3c/BRSufxEvl?=
 =?us-ascii?Q?TitcYSJpkb7Md6R7IOvxRyhH8oAyMsyud7U46mT0G9nLm8eKdDhhX2KQ3P3V?=
 =?us-ascii?Q?P6WZKHbm2Nuw07L+LiQkv++0ZdXylCl4t90Q/Wk6PsMsx7m/jcESNKuTov4/?=
 =?us-ascii?Q?CTtoIKXlHuh6gawo3wHbx032x2v4fC7sdvyN7TYGBAAgKdoanY9DLkCHfnC1?=
 =?us-ascii?Q?LgI0tFbRgwrtE1oaky2eE+X94p/FCO1SMfbCn2tAiGRuyfc+gmzWQzihwo51?=
 =?us-ascii?Q?0gkL6BgRBdjCN4wM3Q+lG6ipgbrCj8+ir3bM0lYLQ887T8/yaRqpA+iqcsu2?=
 =?us-ascii?Q?HrfX/98rFe5eYycGWpwSSiTAVocrpM5I7gCoOji4z7qe86ut1KuZvFiHSKL6?=
 =?us-ascii?Q?GTD+ZTnGJVA8MKgQ4p5dFhjq+PD7u6OXYW17NZiCBQgFB+zLWJXkyidxucDn?=
 =?us-ascii?Q?CsbSNlq2LOlnNWIov5AFMZyLLKL4dM5jgPs4Pec0qlx6cJV4vTtw+e+4OB3V?=
 =?us-ascii?Q?BskW41JlBY2V59W59O5xcojDuEbonH5oc2TArLUMpOXxJ2Fm8ASG1BKkWj48?=
 =?us-ascii?Q?BeowC02Grni6ZQSh+6M3/PU/dTTz+ZSZ1DBvRkxU14L2udqxrgTavKPDZxdH?=
 =?us-ascii?Q?hldnNPLHk9c6g1ji1ffYwh16aq7LcL2sDSntg8rocRzicF8jwOHnlQ1x4GD3?=
 =?us-ascii?Q?GzQkZ6FRZwdEqu3lC5mv3keTYA4T3p5egicmuCJ69qwyBOfP5sn//PKw5JF2?=
 =?us-ascii?Q?/Jy81bTc8jPLhrkbf2gkvSxWZAwD5CSUGukzyfFHXqHfABN8bLEqUk1u/5RL?=
 =?us-ascii?Q?idZ1igj6mGvdGtJQl2pm2dv7z+QB5YdGIlgeG9TjAlsRbW/14BS5s++aXttk?=
 =?us-ascii?Q?BN1+NE3qlEvrl3nAFXnY62KVZ/agMRX4pBMZDy9N0J6gpyQAPoXWmkUp7oe+?=
 =?us-ascii?Q?VeQa7NN5N3oOpmAf8IWLUfCcSC3gIKeRy88GwXoBP2r3WCQs4hkzAx196X8C?=
 =?us-ascii?Q?d3nDkSEZEGcBY3GW+RCIf93FJAAIVHrTBT2E8K/YsfQfsCfefdgLpKeX1x7E?=
 =?us-ascii?Q?4ahNUKhnITI4SxQpzGKULHvzWQmE5lTb0EqW6L0Ok4bgC/XScdFzLAC+2u1x?=
 =?us-ascii?Q?j7XGGPy/EVWOTfOpn8IIgNoOi2oT9o/m/uI8b8pcOzCjNe1Wzyvn/SKTbGJC?=
 =?us-ascii?Q?guutVoAUn7xXICPs5Xcdb9qkZpxCDclX6P3eXSNI5+j5uWZDoi8pKFO9bvbN?=
 =?us-ascii?Q?jrR4/UIDyRl3x1zyfqJDfG0T3To9COLjDWV5GXLL3aAJ2P98co7deAYtDXge?=
 =?us-ascii?Q?+zm6QtA7ysw2ihvyUWA3q/ENv1OZ8uc82jlmADFwm/84LzPHgsKE7LLQjyRZ?=
 =?us-ascii?Q?leLSkXb2Ir4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iwCC2UVgNVDz53udTKFay/KRFyZeSitITat7QRxVddNWre5R6wT30wo2D87A?=
 =?us-ascii?Q?v9NAMeMrXvjcK8hHx7SE/UtFambmA/yVVCWBSq8gSF/NprW/w9OawfBuKChv?=
 =?us-ascii?Q?+yxF7UAFOpGDURc7zCYCAqNmAyrdrJcoytRK6oBxsFJ5USTbffAKUEYy/m96?=
 =?us-ascii?Q?VEmtFS8gpzKlJ3oN/iSNO8EQ5kDsGgYDfZ0n9U2ejc4dDnEXfR6Rg/RWRNws?=
 =?us-ascii?Q?t2QH0ukDkNItiRAqG8mxF/doOkaub/aGvzxSgOgyKMkhrlQgYepNXB/TV0il?=
 =?us-ascii?Q?3qPXaWNGtSnHLXhr0xl0IxqyMuLCv+QZ5Beiawimr/WT50CUquRzYODoSoFN?=
 =?us-ascii?Q?IK4NtXyCI/PiaUQl6SFxQmFF6HJpc4sQDQfGGJaghOEm6oTJqK70Z9/09xon?=
 =?us-ascii?Q?rFcZz7MQow2J2qGSBV7nz3NmTHG47fP0uoOQl0aRb20iXs1Fkm4ZPfLjfG9U?=
 =?us-ascii?Q?T6qDQ0RtVbA3Y4V6Al6TEtqhvPlR73Ibk3D1aM3BWE6y9bulDRwYpi7CKxIa?=
 =?us-ascii?Q?6u7a57g0OpEJsmOYpQPmKokvGcv5g9YfPcvF/OcQlcpzETz+aXeB+k9QCPHK?=
 =?us-ascii?Q?RBbx1IwcpLMVGSOLXM5QyZZsicCJoU+P2LbX06W018aWr0Ibwrd3YzDQxiW4?=
 =?us-ascii?Q?9b5fbPLMzYkZa1EDJCfFHvQngvnFDinNDCFJedySHWbQtWt0KvFuhzsCFuBX?=
 =?us-ascii?Q?lnkGIvljqw/F1VKjYFHpG0xwR/0WWBU0hqO7oVFCewJsDPPWXf8RxBYIUY5I?=
 =?us-ascii?Q?wNAiHjPm4fAG9JSf22Plptce/BEkFJ222CtOb9yk12LeUMTA7DUmogJGwtod?=
 =?us-ascii?Q?6ZSpJ2UTz6BUmMXoYa1ZN3I/9hb8KZr0Nq8l2Yg+dsTAVhTkmyXENZ3QH1X4?=
 =?us-ascii?Q?ElCUdb2nCNbErdpZeVyIjFxXOX5PVx9KpOriYibkv8Q/S2vkzrjrpbrHezCq?=
 =?us-ascii?Q?wEo9Xeq0INbyxB9YDR+qmE5SCNUcHgp4wdgsVKrruNjbx+fvxjHJP65PDz0b?=
 =?us-ascii?Q?mMLg3pWU1VK8B6ALL0eSFSNH0qcYYlQQQRBXsV5vBcTTF8Yd34S2m1ZtBWgD?=
 =?us-ascii?Q?Dm+/Jz/t1vfvGLKC9QawX6xoCoRNA1bV4jVZX2wsqZeWF6illfdeyYKylAJj?=
 =?us-ascii?Q?ukxkwVC5i9Sree/6Bm52eSE3Gpas9RgRzUbPlFepLgEF11Jhx9JEUNURZmlU?=
 =?us-ascii?Q?nf1csY3Tjg+Pf/6EeQox2Fv+fOxe08KSqIUG15g5LLKOFeUTIxp4Zzg6/Ofb?=
 =?us-ascii?Q?Lt2+tG2qapDmWqUk8yeMBkJNqT7Px+FLIHKUZwzvcMlWezY2bJGz4PLQ5fwp?=
 =?us-ascii?Q?ydobLnieY54PbHhbbIvWEiU/wdqapZd5187hDG7SJbP2CEAYDETivllg14jW?=
 =?us-ascii?Q?UzvR8uBnrqK6Ww9NxK/SkvI9Rb7Uj8YnY0+N5ExSN5kHQGbrLg5DlzhPSPJg?=
 =?us-ascii?Q?zw38H1VyiGwwk+Ylc2vZOpBYQ7rHRBZCAmuQsbeCYBv0w1cjuD9O7l0q/Vg1?=
 =?us-ascii?Q?+BjBBKZyrLBw+OAtXpX5S9H5LEBv5g5Rr13W3ao2dpIHrdF+SUsFn6MLTJGP?=
 =?us-ascii?Q?XBtksZnH2XXmICzBJAo7mbOF7uJFTkupRqQN/sBJwwQKby04dr8w7JEnD6D9?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	raosCcSIPnepDvFcs4BzXxz+4iWUHqCTe5JcY8/bstW/vYquWdUlZQwcjLqOrZ7J+IfkMPWS/ishpTTgFqniXWU5ILoVeJ97JwC622dCql9mRHMbRM4vkJAoC797zBIw1J61AcYumJFmJqD41XK2r8JKyc+6YvrYRBleaVWIbhgB6IpgO3MpSLfsNPbh7onwf51Bq8SgsyxYXt+qGZl/qHoaqv8hcPjcjnSoncH0YHwFlgiX6rVipiXKfdkAtGQzcvd/eda8LmdOibUzL2eju3Jasyzw1iLrmuNCuthk0XIeqgiA/mX1S8cvclBiPsVSHK5PupjIyzLPElv/4akRcu+qwPK2wq+4MJ6gabdsVtKrZcWyoLM3w8I6wYcUA8ue0GyQuSr6kSj/im8DDjlO9rJE3+Svc984803R81V07lUaoifJc8Iw2owRZnwD5q1aU06d5UgwwCJh6+gRuTZMf1JgFw2ZcHSFhfpUT2MlCxjH8RcuBqhE8d+vd4oar9XhRqSQL5HgX+YKhnG9eQIBZTxdTfOwm8KMrp6Qt7lH9eR4VJXCaVR8NIUxb578HkTK9FJzg4GELqDZXjIz8S2tcWy269xsdl8oVmA+mEVl9WE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600fac7b-c9e2-4d7e-2ad6-08ddc9d607be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:45:24.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYm455oiKQVtfHlPCGx8ahNwjGIYAdZwiewTb4Ugmj0rFB4gWlZ60BJ5DWJfLa5P8Tr00rmI2PIqn5yPX8xGDkcomifkMhG+tSNA3u3yvgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1EC0B6C27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230091
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=6880bd48 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=MyuWbYkV9QP5UU1-1HoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: _wrwRz0W7Btw_monkfZOspZdCrTCCGle
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5MSBTYWx0ZWRfX4tNPv592hMH1
 4MLSaKRIl0U0TkP8hpsh42x4skDQ3tSOdlhYwVFCK91vWh+RhVknskhg8iQESXYqQmTAQ5K/gtp
 51erQv0/ZKNDKXiiiI47zsT0G/2tqQt6uTGfpa3We2C4n3BeunW9jk08no4IvSJs/DE2y/ovEOR
 vO030hdiBz9/Z3Hq3N/ZbHDuH8/b4yDurj/JqZNSmg25pJk7bjeXAYe8Q2WdgWsHuFtKdlKmoD5
 iZhkUZDN40arNXnp/m3aKMudR3oaXhBBsEoYy6mL2FuJplFx0DxJKIrYvRbzzI5bUmee/VqhgVK
 u8sJFJi80+VKCf/W58kaqZsPW3y2mDeWu6CUQARvqwmCsZV4uzZbymqIhef6XSUg956NB+UV2UR
 CaMMrnpXr72nAsjn3yTesxbZ0M/PBu+SxUtaeoB84+PchetPsChZ9uC97lOfxy+GPl7xRlsL
X-Proofpoint-ORIG-GUID: _wrwRz0W7Btw_monkfZOspZdCrTCCGle

On Wed, Jul 23, 2025 at 10:50:27AM +0100, Colin Ian King wrote:
> There is a spelling mistake in ksft_test_result_fail messages. Fix them.

Oops :) Thanks!

This is new in this cycle so I think Andrew may just squash this into the
relevant patch.

>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/mremap_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index fccf9e797a0c..774cdba102fc 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -525,10 +525,10 @@ static void mremap_move_multiple_vmas(unsigned int pattern_seed,
>  out:
>  	if (success)
>  		ksft_test_result_pass("%s%s\n", test_name,
> -				      dont_unmap ? " [dontunnmap]" : "");
> +				      dont_unmap ? " [dontunmap]" : "");
>  	else
>  		ksft_test_result_fail("%s%s\n", test_name,
> -				      dont_unmap ? " [dontunnmap]" : "");
> +				      dont_unmap ? " [dontunmap]" : "");
>  }
>
>  static void mremap_shrink_multiple_vmas(unsigned long page_size,
> @@ -727,10 +727,10 @@ static void mremap_move_multiple_vmas_split(unsigned int pattern_seed,
>  out:
>  	if (success)
>  		ksft_test_result_pass("%s%s\n", test_name,
> -				      dont_unmap ? " [dontunnmap]" : "");
> +				      dont_unmap ? " [dontunmap]" : "");
>  	else
>  		ksft_test_result_fail("%s%s\n", test_name,
> -				      dont_unmap ? " [dontunnmap]" : "");
> +				      dont_unmap ? " [dontunmap]" : "");
>  }
>
>  /* Returns the time taken for the remap on success else returns -1. */
> --
> 2.50.0
>

