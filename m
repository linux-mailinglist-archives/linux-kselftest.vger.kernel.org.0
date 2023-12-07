Return-Path: <linux-kselftest+bounces-1333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4931807E0F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 02:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C8B20A86
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 01:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777AA1399;
	Thu,  7 Dec 2023 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kv/xKxUm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rQ1WzakK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD0C1A5
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 17:41:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6MgJgr023016;
	Thu, 7 Dec 2023 01:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=DdZ4XDqVfSfnoBgW92nB5AS/a4FMIBVMFFeoJcHyaxY=;
 b=Kv/xKxUmBzvw1zIGYzk+68cUgSlZfn+nKQ/OPVoBIF1tItTRVGSX+l6aCcmuudMbPrI4
 0B51ALziVUFLk9WQDqV4g3mIsQS9Un0J4WvVrjDJh7Lsy06MBhrl6W3Zf2Xof9chRSkR
 VTl/iykM1MJkyUlXau6Aw41y8JA4wEXOI7ymxXYW1e2b3Jkdr9l5YFHZH2oSRMxQjSw8
 qjWCo7kqIvKsjbKMDpnF4kBzy0UIwPce/FH92S4a89w/qiwBFyKMsGhRytIPmwu0dEEb
 f2bWwxsMMbE48t1mFubp61bsXLnR6Zr8jkMpwQTKwR5qOzOVccPuevJmB7S2/Nsv+5x0 +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda2ryw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 01:41:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6Nkqps039979;
	Thu, 7 Dec 2023 01:41:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan6rtf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 01:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9lxh8OvDN0b4g/YPqicxohq5yJ6L8K/0lA6H+GSh8PMfssGkCWuT2U0SkfySki30bm5hdJj4z9cGi3JxMTxNuMQD2r8IJJXnneB5Db6RXMKLdg08jr7hi6uxMH6qKXoKLRMSKLA7Xfl5K38RB7niQ96coh1AXIh9LayJ5TZxPzCT31ZaEZa8nucb2ReiotsPgwzb/wqtHtVnYY9zb6vKYKLyVgvKz2afa0Vl3vMCkwWRV1NGQxQg3XDwNJSSDG5xsW2T7sbJFe32/UiOVlr2DtAK0F4jdQe70zpdhlPgNJKkf2FZo/hmjsmIzYVPc4IU/hn8FCyC6KdWC7xI4lFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdZ4XDqVfSfnoBgW92nB5AS/a4FMIBVMFFeoJcHyaxY=;
 b=MrNEDVRENHX84Gm8PgFf7VJQN5PJTaxM9irryGUm2W3zyKJioATmz2eEpV5B14DSrg7/u8KpfqmultRRpiZSUBVIHzzoCSSolpjZBNmEenaTfarxgNS1EUVyi7omY0XJOuKjHwd57SWrwiMTT3YkpPabzMjOEpcX3B+4AU/aWOVvWGpuVydU1D9ru0FiY+gOhXKw0pl08ELlYWDaWr6ve4SGVN8pMqgGMAmYGxf+sMiMU8aEvt9rEqz7a6O6a+z+JthS74DoGVnoOUHCGK/WuvVUojpdDnGV5IUyzh2QiEUpLlmBXNR4P8FwJ7lp/XBIDtLGX1tB4vYCzQ+4XOYSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdZ4XDqVfSfnoBgW92nB5AS/a4FMIBVMFFeoJcHyaxY=;
 b=rQ1WzakKzW/sa1SvxZyAxHgWyL1bpS9WB0TaKYg+HgQDCOqazr/pG88h8xkBif4xLxHObL+1LH+OkW+Yvk0dhQjP02t9Orbjda6Q0YaXgRb5I+KSd2iCsY/Z1lkErhrdUFmedKgM1hLhbFYhY4oBggei0pXkVlLcibKEzm9/DQU=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5348.namprd10.prod.outlook.com (2603:10b6:208:324::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 01:41:07 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::14c1:ec52:951f:14d5]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::14c1:ec52:951f:14d5%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 01:41:07 +0000
Date: Wed, 6 Dec 2023 20:41:04 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: WARNING: CPU: 6 PID: 474 at include/linux/maple_tree.h:712
 mmap_region (include/linux/maple_tree.h:556 include/linux/maple_tree.h:731
Message-ID: <20231207014104.n6vul2ylgqjnsfia@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eric Biederman <ebiederm@xmission.com>
References: <CA+G9fYs-j2FYZSFSVZj48mgoM9gQd4-7M2mu2Ez3D1DqDdW2bQ@mail.gmail.com>
 <ZUzmlhvRv66I3J6P@finisterre.sirena.org.uk>
 <B4299DC4-57CF-4CB2-ACB1-A215F429BF6A@kernel.org>
 <202312061435.E57F367C16@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312061435.E57F367C16@keescook>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::8) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|BLAPR10MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: d69554fb-8d41-49d4-dd14-08dbf6c59468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gbQwDyy/laDTBF3acZ7yMrajwhnDzlMvSXBWxC7M04/nAnzxKYxXm2un94+5xD/H2LlpINcQmHTTGtG+UBz7gJzIfz7F8ZSf6VXyqnmTBQBeYf09VOWBEaxuVXZWkY3qwrqGp9U/L70zMf3b/vwgSXw5iML6aD/N+KgLsIFXW3tEW0IfzaMzluccpbj7m63bX9WO+ppe8Wyv/VUanfBP+bLhgFkno6PQ99w2lM/aYGerKzfyGhugcoLJG2+k0qwYKUgb6oQ++0jneEwYl+5sQ2aleo+3iwftGpX8hNRMzcDAKDNJY/Ag6wMuGpsTPqS0ixaS1AoikRVed6JXhTBzRUdyINX72irshwRk7eCG3dxPz8iqTYzBX+WZ+mtGmJc2z+VH3OvHnZ2/Al060fG7mp2/y9TFvDeHtnYQf9iFmCeK5EJVHi5QFZocvv/98bZ27B+m4vq9+RmsztW00reYZB95GRyzNFjZmvIeNaUb+90nnsiJn4W8hNkV0RvLvGjtgc8SIKcjrbrrSFXK4NhlnydhnBsHaFFXcEN7UHXdcVGwc1HyuyXU+8fJ9bmGhpRpCyLEtwiANne74V1CkTFwe+tl9JYXHRsaEVqoTBOLu6qnvr9161WszKCypgibooloUs/K6qsuFQP9ZQMCVmVWcw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(8676002)(4326008)(478600001)(8936002)(86362001)(6486002)(966005)(38100700002)(9686003)(6512007)(6506007)(6666004)(26005)(54906003)(6916009)(66476007)(66556008)(66946007)(316002)(1076003)(83380400001)(2906002)(5660300002)(7416002)(41300700001)(33716001)(72063004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bIZ5R73wsOhY5oUlvpKqXWcHNNPKkEjqwHLoz+DlikYBtPhOj3ABS7EU0xRj?=
 =?us-ascii?Q?KLtTP0I63ygC4efqrJQOY+satVWVMKZPZ1k2SkjtznHgCHidWEg5pk7VNxen?=
 =?us-ascii?Q?eh0ullDSA9tL0NmVDPVKtOSqDprLnx1GDwgLFi6qUEPCngSvSHLLvDhW0cUJ?=
 =?us-ascii?Q?mxyO7THqGWf9SjuKWzLb+Fqf64+woM1eTngOUMqiMoeXvzCBLDIBdK7BocHr?=
 =?us-ascii?Q?rTv7YWQPGhM8IKbAzD1uc8wT9YrMjAKWaD9/OvrZtdXsAGpOvxc/YJemf9jX?=
 =?us-ascii?Q?OCwpXou1Ko+Lipc5e8cRtYuV4YP8+1H9z3FykNAO5dX2U4YJXFQvk27FkmWF?=
 =?us-ascii?Q?mke8s+QV+LfbCP4bXx838VsxwUnjir9J/L+YJUHmK8ptiorH4sBFZNJlse26?=
 =?us-ascii?Q?PbJYgt38pn1QuC8YuPd20A7zxRtj6Ox1B//w2tz4zqHEeyTGg7xmkt3H3Bvl?=
 =?us-ascii?Q?vUWHevwudCtIj3l9/mJT2eG/NA/lrSgZY+4T5oFykMcv7fZdgTDq/a7o+OiA?=
 =?us-ascii?Q?qfEjZbCSiHZoN872Y3xT5mAncczZeoglPcNr1rDSWVWNp4kAOOwG1GEwz380?=
 =?us-ascii?Q?ijuwzHU1i+DwkhbpXiRkmbU/ymz74bS7golHmUOKe4sSWZZbV/XnsBzgLKlb?=
 =?us-ascii?Q?ydZjMBnpDTu8GaaYCc7KOTbmpliky0Zrue8ycSn8ieyl+EuvjNeZNn5KDyfl?=
 =?us-ascii?Q?+axrjBWXMSOTfz0sXwx6N2L8RjmSdpXuyNwUgopvhwlRHDQLTKPuriNBlEP2?=
 =?us-ascii?Q?pIlpoJtXQcqQNV2bdEFViYV4Uo7BcHFQEoT5rb6t5uNFwUjY5+bqz+k2JJVQ?=
 =?us-ascii?Q?+vXfNDrM8M1e4TehumnhEfnsEaPdd2anmuLDWZR1FFHE5lpaRaw2MW7lDS8x?=
 =?us-ascii?Q?HMveVDY93vnFazcNYFGZLabmaxYHFKVmCh2RlP/g3llU0wsvfS4tnDMdV4MI?=
 =?us-ascii?Q?yZZf80+X0POLCX6wHcEQyfqc+7xPCCopakYkBDeL4SXIZtDm234BWLW/pfIm?=
 =?us-ascii?Q?LIDIo/jVYSIibAxdi6UGh0z4vJ6gve1sgUSL4DAwk1Rq2vq8zbYaP7DHNiD1?=
 =?us-ascii?Q?7CznzbKcdIXPvVoKY37UVV+eoRiQmaZcd+YUfSaRviX4ZsM835jgABu+c2ul?=
 =?us-ascii?Q?wIhfxqnNekIAqDDAs881trEiy9nPwyN/CLZ0qfO9ti6KIRmntB+H+IO1BjIX?=
 =?us-ascii?Q?WxQLD7dYeOQx5vA/dyd4JzXB5DF9I4uxC0MYxI5f4QpkWEJNzQLGaYXvccoc?=
 =?us-ascii?Q?hVWJA/waVQuxq4q4vbAESQC0E7zHS4Bs8gR3Sg/ir4j+9ez7LjOKvrGo1p+Y?=
 =?us-ascii?Q?YltY7tVLUYPFz9NME3FZOsnxFO0o/evbe0cxxf4MV2AB7oGGJJxim19rYZpb?=
 =?us-ascii?Q?BNLfGwsskWp7x6kFTPFJbcyjuXxR0XT+v6+nxq/vNMW2rhXU+O9W81m40C5F?=
 =?us-ascii?Q?tMBGS11nkV3oNPny1xKVPYvCVx4SWZu/pS90AbIM+8gSlm3/gH2ADHzk6jvX?=
 =?us-ascii?Q?WQ83FbtIojkVW04ep+pS89tTrQPt6KP6+GTTQIGJCGlsQfk9V0ZkkkwFtLKu?=
 =?us-ascii?Q?FJ/kCsXQU0Efp4Paivoqx9qIpNsmVMyNhacZv2zU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?WLLzS/WCl1ID9eSmDX8OnbFpKtp5IVU8nHCp26HUu6kWjRJWZxstx/gg/OAW?=
 =?us-ascii?Q?5+N6iG/bwX/RKjh9k3SB2QB9RRsxb/81ZtCmIMTQzi7oPd3v5TPRkPXqpA3L?=
 =?us-ascii?Q?QryiabjZM+LFOB48Q7dkJW5++Th0JKv9bmKcenQP/IwGzTeQdjFNHwmLWHQK?=
 =?us-ascii?Q?Lh8dn2eQNySHMj+tzhwX/d3ZLW1FUpkHghJhi4jjlrw/HsjXaxMErTSSJCNu?=
 =?us-ascii?Q?0HXnGj8IoncnS1Ud7fusdoGLnfppXURYXI0sp5YmP4z51kYMZ9QqkYQwjE1/?=
 =?us-ascii?Q?NNpPjmh1N3mzYLFtScyF1WCvbOnW9fcIgiAAW65yOk3eHYx+Hu9HbEsiRQz2?=
 =?us-ascii?Q?BZUyMuNs57q0HPRL6ocbWOlfFCDssz9WYRsahQl1ZqkW9DicJSljNzI3X/Tw?=
 =?us-ascii?Q?D2d0rC5KSlYDFdbJl/QFZS792WzzfhEtETOYC4VOF6sZfYks2I1pZLjLkzZ5?=
 =?us-ascii?Q?HNFFKU3yJVDKWELoEp8DBNhCeqIKUf4qI0GsGxkZXjg3G83VUHBm6+Q4oHrY?=
 =?us-ascii?Q?WoO3myW8Kq69OVQKkrEFQUmsUOgzDNPEiB12ek0vfHMhLgmZae5vjDuTlCmA?=
 =?us-ascii?Q?gJVsv2MvF2mZjnV+cSX5zjw04xe0+h3Bf6KN0Q+1/Rlqe5ZHRatMtpM6TnM1?=
 =?us-ascii?Q?tyCYK3br4xzJU61vAPmdvamvj9vbhM27jCwi47/r3ktCiMr3sQrhB5UO8zzY?=
 =?us-ascii?Q?pKdojplQqsEpkhdzz+/nmqTIqUwojXVIQB7Mw9QZtxPAl/cAKYwp0OB2lNFS?=
 =?us-ascii?Q?ro2mb0F2KCnw3ZnIgm/Hzb6k2gxqcnTvRFAetFyxSxaKW/bnm3oNM2yVKgFu?=
 =?us-ascii?Q?jlrMfBy9BmWylfh8jIXmsfXNgPC8mEZphJCv4RVFI5ID0eIQMb/D6x4iduyW?=
 =?us-ascii?Q?aDqrKEseM0EkSY+WQvW4mvnDQlYA3VEAFeClh2DJR5WfnzVJ4Lzn4FL6ejDH?=
 =?us-ascii?Q?KGpXXZAdZrqukzj8JWSeaStzU/n9uXEDgK6HfO8OeHVuiE3Xy0IS1d/ftnMh?=
 =?us-ascii?Q?vM2iVa86gadeo6iFFh48Or1tlyB2TKEG8RnVk//PuDNlj7/nsgInTIRo6KQs?=
 =?us-ascii?Q?wNXA09P4nTvaUv2ZeRudryuH5rXorlv3Znqysz7pSMOaHbDJr8vH4hglqhEl?=
 =?us-ascii?Q?iISWAnoNyVCo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69554fb-8d41-49d4-dd14-08dbf6c59468
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 01:41:07.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJvb4GNXPuqYZN5zQ3e4FabYEL5GuZCoLRd5hMEo+9dG7r6DRDBYT4GpLPSrkAsKSnhyQwyF9KQw1fx8XVJQ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_22,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070012
X-Proofpoint-GUID: ibekPNYFXcSkGwFI7pFiE_nbaWhKzMzq
X-Proofpoint-ORIG-GUID: ibekPNYFXcSkGwFI7pFiE_nbaWhKzMzq

* Kees Cook <keescook@chromium.org> [231206 17:38]:
> On Thu, Nov 09, 2023 at 09:45:26PM -0800, Kees Cook wrote:
> > 
> > 
> > On November 9, 2023 6:03:02 AM PST, Mark Brown <broonie@kernel.org> wrote:
> > >On Thu, Nov 09, 2023 at 06:57:08PM +0530, Naresh Kamboju wrote:
> > >> Following kernel panic noticed while running  selftests: exec: load_address
> > >> on Fastmodels (FVP) running Linux next-20231109.
> > >> 
> > >
> > >Copying in Kees and Eric who maintain the exec API.
> > 
> > I'm traveling tomorrow so I won't be able to investigate this for a couple days. A quick look makes it seem like this is only happening in -next? (This warning was recently added to __mas_set_range?)
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/maple_tree.h?id=02eccbc51164b43c5dadc3e5b40922c757075e08
> > 
> > Adding Liam...
> 
> Did this get addressed? I still see the warning checks in
> __mas_set_range()...

Sorry, I missed your first email somehow.

I'll look into it.

Thanks,
Liam

