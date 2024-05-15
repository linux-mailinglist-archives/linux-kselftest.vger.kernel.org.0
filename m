Return-Path: <linux-kselftest+bounces-10266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3F8C6E8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 00:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CC928385F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B913615B963;
	Wed, 15 May 2024 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+fQndcR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TpWfKtEY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B815B57C;
	Wed, 15 May 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811601; cv=fail; b=DqUNT/dBCQaEvY170i2PXVUczMdbh+Hn9Fku45YDk/GcTLmcqm3s0OK1e1lwCgckj+I9v9EcaxtUIzTR4Nt0lSl7dkVBtPaEzCQC6cKn23OHKN9ugr+ClxYLCvef+4lrYTHXZXbn6NiD0OVF5l7QlLzL/HocR5YZ8k1HXQD1Bck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811601; c=relaxed/simple;
	bh=H8bl4qJZgCtd5qRBwamjMfb3cTHMINkllmUrT2OcItI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9F6lHoGMRjepoxVGrDi2MtXM79Khn+Ud5xhDfDEAyyUxnl63s2ruqh/WqeHI1zSFlb3cRC1yiRM+sVz0/CkJ2ifNRpd4g3sZ3lLEXmp7r2yM0R9lwPcttFaGn8MxzCQN99aNP02wwcUbyJ4RDQhpecogU7IuXn4lbKDoRxtzos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+fQndcR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TpWfKtEY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FL0tDk016064;
	Wed, 15 May 2024 22:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=DR9YyQ08TfwXY7S17fOHSgFg0TvxLtXsd8V2X1LvMag=;
 b=b+fQndcRNTtkf2vEoPknV6UfeiejBkV+lX3kABG5nUgO2puHmwgEk33w6FzQ9I6xNr5F
 FbFio4iwoWeRuL1RaPkTn1JEiZBm93FB5v10PJuPdWRdqqC/2BGX6mg0hHtsehnlQmWG
 uzHzF/uW+9RYJJu8uPMQ2rMVamWQHg/6HC/GirXPLhmnT569onVoyWTn1/giOJLY+Upl
 jXy5LWk7s8FMZt5FHhFeViYB12uqlru5VX6chztB9SMCUIQpppeynNnaK/BC0NDjsImd
 AY7nhcqIPgIF8JcuQMOpXG2laolLffGQUW/egIzMWQ+I8Q1mHm52uPpwrtipw7+MAgF+ Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4rva3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 22:19:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FKV8lW019166;
	Wed, 15 May 2024 22:19:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r86y8qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 22:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCmJJFk4TiWrFpYAK9vhm8gPoZXOgVrjDeT5b3K0nA4/HZfoCRusuIfsqTyiGlqDJkmAodGka68ywnMQrShSGTj94i4bw2DB81pK8cJHB8eD56CLmgLOSM+0I0EuEPeRzhnwYxIQvtfbNogcIuRBOSUvpEyGTyIkE5KocI24MMXM1DTzdt497Hmi78YYRmcX9zlIOUkaQ4SKtr5aAic84KxSYWDlux6Md5dWk7m29pTB4bGxuKIxwS7Bhv9dxH0ae67VrXd76ZEapKhBaHvg6eBkHN7LV94qELLCbl9/Qha6ji3Gji7J9pQMYhslnMquRydRlYNUz2NdLmVtoWFmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR9YyQ08TfwXY7S17fOHSgFg0TvxLtXsd8V2X1LvMag=;
 b=EGyIOBtPK0B+C+LiLUV2/XLpxo/XB1AGDOx1+cZxQqNEu93aKyPc4oMgmKd6HQo4d4GhpX1ijXt/xoZSGObtoTtodN41G6aF5J5qMNbeba3JtdxS9/F8quunEGNWF6N3mBDyS+JE2flNrvu9KuRQ9bIEfI01rO2NmPIzlamjYC/UylWjXcV8KSDRxCeBbB7iePuJITMiKJlnRbiFHItuvv7D31HBNKx1M8g6lpAiFMv1I3qAlaO2MdfRx8D0oTcX30uqTrnZSNQuezw4v5exj2lsrU5+/QHkXnRnp1iHuCaeWp93LPMEB7Goi5jPKeSRF69XUVY9DRZsW6mubJg8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR9YyQ08TfwXY7S17fOHSgFg0TvxLtXsd8V2X1LvMag=;
 b=TpWfKtEYZVP6/NcXCEL5CEIH0v2nBwkjR05Y1xYe6TywHd5OjVHykbXzEndhBuenSNKgHGvAdRtbiEVTuOcWGhGPIHHdcyfjLC+eAXKEEY8ug4nwRmE2TViKSbrYctMJSz85S434v5ERaVfa8VKu+Uo/y5YplQ3Ytd4r1f0G9wo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN4PR10MB5797.namprd10.prod.outlook.com (2603:10b6:806:204::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Wed, 15 May
 2024 22:19:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 22:19:16 +0000
Date: Wed, 15 May 2024 18:19:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org,
        jannh@google.com, sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        usama.anjum@collabora.com, corbet@lwn.net, surenb@google.com,
        merimus@google.com, rdunlap@infradead.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbayw5ntgk5a2rx@jkccjg5mbqqh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	corbet@lwn.net, surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	pedro.falcato@gmail.com, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	deraadt@openbsd.org
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <d46qb2rkfsagw22u6ishgagsvsmqsu5nrmf5up5mhi6xrwolyt@6ir6g2v63of7>
 <CABi2SkXBpL8qdSMTwe5njWasqidsWDkhme6xw2_38JARrhPRwA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkXBpL8qdSMTwe5njWasqidsWDkhme6xw2_38JARrhPRwA@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CY5PR19CA0065.namprd19.prod.outlook.com
 (2603:10b6:930:69::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN4PR10MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: db2c6a04-8c53-444d-573c-08dc752d0e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PBOd2+Z4bHUfpaavJpmwOBQqrCocXGi5quj2RLk/0mUommUvmxMYLSrBMQbk?=
 =?us-ascii?Q?sjpkvYs7KpOKsFf7P/COr5SfiEwbiV3DZ32Tzb260WK7lW1Qco2SeM8KbRFv?=
 =?us-ascii?Q?5PpT03/O/gmFa0U6oYg5yTCOmXOz++mNtNNP4lN7klWGH3eSawy+0/aYnMCC?=
 =?us-ascii?Q?REZ0qmW1lrm5Dh2EZEKukRo9OhhRHS3iUPM6TSgTnd128VPfD736jF01CrYy?=
 =?us-ascii?Q?1HWn+A7SOK0noPnTRgD9ncvMmT7zWommqiPJje2Yg87tGSSMiECg2+4A8aIJ?=
 =?us-ascii?Q?I8XC1osHFDduWtWxY893HVjLT8h/az1uIJqT/OcqMKSN6vgDV6NMXiRhPHhG?=
 =?us-ascii?Q?Jq1eBbr2fsn1jmaQUvW2DhLqC1c/IFdWurNHtUufXG2OxnIzrXOFkYoBHVkO?=
 =?us-ascii?Q?c45sQBc66GBps7Sf/gk4TS2FdjtpISJlcL5jCPLNZPdi44gED4qomnX2pTC4?=
 =?us-ascii?Q?K0kS7eX8Fq16bGQhclWTZhKePp7bpEUdQaQOSNJ+A0httZaKXzqgR84v03Ux?=
 =?us-ascii?Q?EYSce08SjD1eaw+PPGGIvCwLJEBuxK7dQ5adB3nOLcoJc8MjnmS52eA0eu7v?=
 =?us-ascii?Q?Du+gablHSGNu9NfCu47HclvcO1aYi707kXDen3OLIwMAa+3qVYJgEkYbRSk2?=
 =?us-ascii?Q?T72pdlNarANQUkBzb4hoGXUfiv6KU84w2iTh40RBnlFwWEDi1/yBoIo/tz0a?=
 =?us-ascii?Q?ABoLgdEbyvTqUKb9eVavoKUHhkCjev7914LYeyICOZTLLvtQmc/K1UQEpDy2?=
 =?us-ascii?Q?lNIXgGYaBHPPg9loLADxzBmUgsDmzI+a2ouMQZJi1vwATpxfgwyVLN3yCu0M?=
 =?us-ascii?Q?ZgwbfzV09WnMzL4V0v3Vz5gfFaIVSMU1SuQxPpwF6xO7HzL5Gs13noNMmJZC?=
 =?us-ascii?Q?xP7EBtC6WtvV9Cdh3+h1Hz8cF/aRG200fBujs//qYs/Q4LXONQMQ6gbXOTSn?=
 =?us-ascii?Q?Ay5ptQ+5gXyAqEmgFrvolB/+4x4Cc/jMgY83LwiartQ0KRYB6ucg3uwpQ7da?=
 =?us-ascii?Q?Gkd5UKsn0xABPcbBa2+fuvQ9I/ik8eisaGOtgXvStt0iNJEWFG5mTlbwcJtD?=
 =?us-ascii?Q?JpXTaPdwPRfSPvRq6XwPTXsyEHoR5Q5fFtyqL4gX8+1IMmzhn5NICpbc2fnB?=
 =?us-ascii?Q?10Omztod62YpzAjXZ8IrmPIjYHrqS/HWfTn1w/cJDwBNGSkU99DTjHQ+PzjU?=
 =?us-ascii?Q?FI84smIZwr8QbiTJVPT4FxFNkqb3UG6Gy4slMZwUXS0G3SRyutiK/9MnFnAw?=
 =?us-ascii?Q?MR0/iO+wDJ0CPpLbmW9LtGSThgRkdjtK7CTMymE3Dw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kdRMoDxEewTsIzmVNf4akcxk8xAAN22TgnCBdNmgnvwUweU6ntbWgIJP3fWr?=
 =?us-ascii?Q?7P7dEd8t7xOK7eDMWtjV1hxiKeDaQ8ljLyqlebzLexA2dG5kssSSlo156ORb?=
 =?us-ascii?Q?Muko93f1HpyYB9Dqdd2UyjeRSSaMCNcQApr78yqe706o1xP4zk9alMpDCris?=
 =?us-ascii?Q?jJABhJWs8gLhM7a4FS4oysRp3Hp7Lt0ijd6GQ+rRPMM5hT+ODOGBT+BeH64b?=
 =?us-ascii?Q?giBtPu81gZOiAvMo5Apilh1jZ5vw8oej3jqThdMezGAA4dVq2HEmvLXn7H+v?=
 =?us-ascii?Q?X/N/9PEjHU04vX4xn679L0xcQcoDlTwss2h7jNAuXZhNzehDZg2F/Lkzdbkn?=
 =?us-ascii?Q?71RX7VuBqpn8a6jClpQ8Z3Lw9fL3sXoIA+yibUsuiqTfykinrmaRRhD3biof?=
 =?us-ascii?Q?MSARsKLrx/HhuKklzyrjxILWqky29jOPN83v8yvYPE7cxhj6f+IAS1+qrr3P?=
 =?us-ascii?Q?g/D5wtqJDPnyi5Fpd1ckCbO3fqHME7XoqVFzoBnQUUjZNpQY2hTxTGgFNl/r?=
 =?us-ascii?Q?wp3+DfccrwrEq7YGlclhPOy5Vm8Dk6M26pn5FymDEa3eZ31fwecFHv6XexhE?=
 =?us-ascii?Q?Mc3mjaPOBB7qnYswKniJiicmX1wlYy+MDLgFfFgDomSgKkxitn1y4OsOahfW?=
 =?us-ascii?Q?ti4fzCBFZMouCIEYxevLsV9MRH5/xK+a1Sv6rriedp0soPvAAZlOHNsus88c?=
 =?us-ascii?Q?Uq4XtY7e64O4HHNZdv7TKaK2mnH+LF+L0bBYiYG5Y/hUnv2+QUQbYibbIzqI?=
 =?us-ascii?Q?Ik+mmd7eOmtsEjyPepeOtbCWkpA0tbHtWY/DF3LPm7ul+5AmBnHj8Akb6QdH?=
 =?us-ascii?Q?577dREG4iNM2pvuVwY/Y8ZsSojREbyF7FFKIOMfHiv5VCqAAmrgMQOCTh6Lr?=
 =?us-ascii?Q?ptFKr1HuRt+VaSMmDrIFnhSK6Mdy+F5Sk4MgX/1FZiYdhgoMRdwiFo1Tklqo?=
 =?us-ascii?Q?OtEZGZucs9p/L+GRQH+VOB4409KZZszyyCvqNinyUSE/ceKwRPjipQVp1CFy?=
 =?us-ascii?Q?/Uj/IpzJC+AKPF/EtejUX9jTRG1pf4IK82/WKXhW1q18ow7ro394vftySnfL?=
 =?us-ascii?Q?1cqbXg1FobGUoVnjc/sbRoTXm9IjuP8rynm+jv9tutFHjFO53Sc9x9Db+GSb?=
 =?us-ascii?Q?+bBisPWRnbxFL1cp+OEWy6pwo6lIqxKrIVfQXIEIKj/pv9fxkn4k40j7UiIX?=
 =?us-ascii?Q?E6DdhXk0+7KX/lUxzoJqUTyO4ojMf/6AGDeTFTpZCnoNO88GgHg9UZJqBMSD?=
 =?us-ascii?Q?GDeuqGMWrge+p52+mf0P7gmbBDO3J/6I0R2eWRjZmSD310VnM3Snph2Tvt2G?=
 =?us-ascii?Q?hkYT5bTUQKlJSAd/jIu2LKC32uagl6kj0/70r3zXYO73UPPjRPhw1lv9+/h0?=
 =?us-ascii?Q?q/L5Bpztw+lZHUXrXyaQkBhSbVisEOXGaob2M70Tkhjr+ZuiejAyzAxgIYs0?=
 =?us-ascii?Q?f0WKQgYPZjfov/DvdzIXToiqXLcCT5mH5zu30iYFwmPD3K/Lq6KiybOLyfip?=
 =?us-ascii?Q?c7ZtN4K91+1Cs2ZG7XY2Fa3nZBKGXAEJAZOLDPp+g3kSfE+kPV22E4Lmrizx?=
 =?us-ascii?Q?dSE+X0cU6v8UPZTgRRRfDHRDk5me7scNsJbsSam7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WrQR3P2vneVGhVXGSaeLo/kthVRY1ThMjXYhlOzo4j4MXrZyTN2Gh2mFHV3zuKP4bVIuTOWziFalYpoejXs3mZen29rsmWwgnNIujlpSo6n4o0LPK9qI/7DGUCHDtqxdDvSZCjmCvj8EJ/sDxLY09OfQC0uiXZ+busP/URB7zT/XC7kmnzJJWxhscsYiJYXrbFtWxUDG9zC9wyxR9SFBslT4J/JGjxKqglGPB9PmOD51uRZBPu0+X7yy4EvmiU1aMAthtMRNuoH8YPtGIitaRWLQ/1ox3+jN8cOkel/4y+PLH/onTaFIrq13WO0RSBz5iLyqWfuOy4nXmB1IipFFuLPl3hBjP0DaNeD1eKHO/EMli7cx8zwGiXh2SKLE9G1lUIyGDU5LyQUTH/9zHlibE9r18fh2vGRttfmBCOThLsaLBwxC3w7y2zHb8mkWUPZwHaE9tSYZVdI1z20kphYXrZgld9vmO1LO7sXDmOutORTTJU08t1WbRutQAvDKceu/+PDbqE8k4HFkAbwEU6VZ/kIWm3pR9ky0XO4UQDMolasJ5w5WfeuOxYe2jsUJ1qY0dDFQpLSyEyDxq7TbNIFLrZGS4sD0P+zNZ7hz3u+ddBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2c6a04-8c53-444d-573c-08dc752d0e93
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 22:19:15.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA0dtwmIFfbzmxQVxrZgM8uGhNNfKHJqbt8XkaEUbYNSqKd1u89bJ+aR4loazvynUnw1/+dcBXr4XfzYRvkhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150160
X-Proofpoint-GUID: A0f7-j-Pe7v3HoaDVsuGAvGQoQwdL8KV
X-Proofpoint-ORIG-GUID: A0f7-j-Pe7v3HoaDVsuGAvGQoQwdL8KV

* Jeff Xu <jeffxu@chromium.org> [240515 13:18]:
...

> The current mseal patch does up-front checking in two different situations:
> 1 when applying mseal()
>    Checking for unallocated memory in the given memory range.
> 
> 2 When checking mseal flag during mprotect/unmap/remap/mmap
>   Checking mseal flag is placed ahead of the main business logic, and
> treated the same as input arguments check.
> 
> > Either we are planning to clean this up and do what we can up-front, or
> > just move the mseal check with the rest.  Otherwise we are making a
> > larger mess with more technical dept for a single user, and I think this
> > is not an acceptable trade-off.
> >
> The sealing use case  is different  from regular mm API and this
> didn't create additional technical debt.  Please allow me to explain
> those separately.
> 
> The main use case and threat model is that an attacker exploits a
> vulnerability and has arbitrary write access to the process, and can
> manipulate some arguments to syscalls from some threads. Placing the
> checking of mseal flag ahead of mprotect main business logic is
> stricter compared with doing it in-place. It is meant to be harder for
> the attacker, e.g. blocking the  opportunistically attempt of munmap
> by modifying the size argument.

If you can manipulate some arguments to syscalls, couldn't it avoid
having the VMA mseal'ed?

Again I don't care where the check goes - but having it happen alone is
pointless.

> 
> The legit app code won't call mprotect/munmap on sealed memory.  It is
> irrelevant for both precheck and in-place check approaches, from a
> legit app code point of view.

So let's do them together.

...

> About tech debt, code-wise , placing pre-check ahead of the main
> business logic of mprotect/munmap APIs, reduces the size of code
> change, and is easy to carry from release to release, or backporting.

It sounds like the other changes to the looping code in recent kernels
is going to mess up the backporting if we do this with the rest of the
checks.

> 
> But let's compare  the alternatives - doing it in-place without precheck.
> - munmap
> munmap calls arch_unmap(mm, start, end) ahead of main business logic,
> the checking of sealing flags would need to be architect specific. In
> addition, if arch_unmap return fails due to sealing, the code should
> still proceed, till the main business logic fails again.

You are going to mseal the vdso?

> 
> - mremap/mmap
> The check of sealing would be scattered, e.g. checking the src address
> range in-place, dest arrange in-place, unmap in-place, etc. The code
> is complex and prone to error.
> 
> -mprotect/madvice
> Easy to change to in-place.
> 
> - mseal
> mseal() check unallocated memory in the given memory range in the
> pre-check. Easy to change to in-place (same as mprotect)
> 
> The situation in munmap and mremap/mmap make in-place checks less desirable imo.
> 
> > Considering the benchmarks that were provided, performance arguments
> > seem like they are not a concern.
> >
> Yes. Performance is not a factor in making a design choice on this.
> 
> > I want to know if we are planning to sort and move existing checks if we
> > proceed with this change?
> >
> I would argue that we should not change the existing mm code. mseal is
> new and no backward compatible problem. That is not the case for
> mprotect and other mm api. E.g. if we were to change mprotect to add a
> precheck for memory gap, some badly written application might break.

This is a weak argument. Your new function may break these badly written
applications *if* gcc adds support.  If you're not checking the return
type then it doesn't really matter - the application will run into
issues rather quickly anyways.  The only thing that you could argue is
the speed - but you've proven that false.

> 
> The 'atomic' approach is also really difficult to enforce to the whole
> MM area, mseal() doesn't claim it is atomic. Most regular mm API might
> go deeper in mm data structure to update page tables and HW, etc. The
> rollback in handling those error cases, and performance cost. I'm not
> sure if the benefit is worth the cost. However, atomicity is another
> topic to discuss unrelated to mm sealing.  The current design of mm
> sealing is due to its use case and practical coding reason.

"best effort" is what I'm saying.  It's actually not really difficult to
do atomic, but no one cares besides Theo.

How hard is it to put userfaultfd into your loop and avoid having that
horrible userfaulfd in munmap?  For years people see horrible failure
paths and just dump in a huge comment saying "but it's okay because it's
probably not going to happen".  But now we're putting this test up
front, and doing it alone - Why?

Thanks,
Liam

