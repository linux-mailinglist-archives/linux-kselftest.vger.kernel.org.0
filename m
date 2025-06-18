Return-Path: <linux-kselftest+bounces-35271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92573ADE9D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF917A4F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D129A9ED;
	Wed, 18 Jun 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GbNBJWue";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qCN8l5jf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC125B1DA;
	Wed, 18 Jun 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245827; cv=fail; b=tDm8gUPuKG3hb4EqWHf6s040nvUDyukWHOQqe62abmAYeHcjOisNkS+jbN3OzuDMhO3RWtCWMkom2i17W2ChONey/5aVw8oXnXV2JuSFoYL2gdhf9/kyflyA/0MQtT+ShOVVDU4bjAQdeziLHKDcMOKviyj6EHksYMZotA0704A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245827; c=relaxed/simple;
	bh=BUIqbUmr5vbf0UrJrSmuDjWYTj+L+lqIkGkj/KkvSaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k2Ba99bSm4ftObLS6nvLpiIHp/t0gIkc736/Kto09T/7x2OrHxkZVz5YAabzxolfjPiaYs/StquC0oov8hfJeppdLBSHmbaNxX4kOTPJ8vzvnnDRuvONQEiJNcDqtFVhY4nzbJGRiZZQQq4rjI7J5dIx5aRmmcvclMGW8D4GkV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GbNBJWue; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qCN8l5jf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBMbL0010737;
	Wed, 18 Jun 2025 11:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BUIqbUmr5vbf0UrJrS
	muDjWYTj+L+lqIkGkj/KkvSaE=; b=GbNBJWueNnGy5WFqaEmgtCj6+zKR91xqGY
	AoXYd0liwSOiKwibF20/MAbHj/g87Gb43e5yjOzkeLqZ282HGrNPQYIKsFcV+jgD
	GSZLjFMNjrZiR4eYaO/HJz2AvWt0KG0b6KICiVaIRchwwPn6mhmCpNUb+jyi7wxg
	vUzdYf6N1WgO/t85BpzpHADUftRCTN4xuQCp3EM5uNgWcY9qKy1Ytddg8J+0ZpW6
	e4Wtl08FriRpxLa5hR3OgTCAZoBVU7xVkaUI1LjZ+2OJKjBsCi49qvXt/9zq3DFa
	rA0UJEIN3kU7Sykqgmx5jNOB4RnXmtXCe8TU43AuAUtsDK0cmcbA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd7hvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:23:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IB2JOU000869;
	Wed, 18 Jun 2025 11:22:50 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhah8tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAEkTeRH7H0v6ES+t0C87INuxLh1/WaYIHGFkMlKDL9ef487mtvNR+4AgONoHyikeXqMz2g202HFC4G6FNg5Y5ozHG5S53rfdp1+96wtC6yAck2ic2OQOJpqhVZrEw7OJYgRKJmYYJ99vIwgdrK/fDhTqsGUNR0jvSLyuMlv+m5nOr1mYkK17OnwS0RdLPutv13MLzqc7wNnKeLMTOYusgmhg+2DtWbiQ6pLCERiPpthIuviEVuP3wPDLs2Sc16lkIzQhlpyEo09J69UfbgYxwxYkXkbdIBYOjcOlaqBcXuCYVj3l4UbNyCrZEkVUGIzVc5TTqlFOY+ngVi2D6ROMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUIqbUmr5vbf0UrJrSmuDjWYTj+L+lqIkGkj/KkvSaE=;
 b=EmfZC3akPGBN6wJW6KsQ7k3sESaVIhW9jvP48k32SN6xgNOr2wAvOHdJFIRWj9i0j0TAAzpw1QbX3P3bYNWdjpPNJ0YUUWasaZXk+LxFP2uEMffpAb3yHobEwEAjjudppHayf0xeWsJL4ns6s+NyKSsxr4ybUi+ppq+4IM20DHhdd0lltaJgWa9K5Mpvm5tmjG2upqahAivQAh7lNAH7tRelj9F1S19sjwFP64BJJyhLPPSMluwAuAznEQewGw4s/stcNBvtqRNVlHItvclj0mZKg+UXKM/79nSNoFcj+RLa1E3uYLMIXkYN88b1b0qo/Qv0r97wsbs8Lpp4st5dYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUIqbUmr5vbf0UrJrSmuDjWYTj+L+lqIkGkj/KkvSaE=;
 b=qCN8l5jf1vXuQS483iMofB/QQOiu37FV8f1hMz9/lSA+tO0My+9xS55ut5T5RlJJaFObB92CXe/UYtSBgl1gKmM0aRUhaKIm+qyZK582uOczezfhRS5lfeBsiAle9+N3BZMLQwd3C06s/DjS6B6x4OhbjTqUgflIS00RttCdRdE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8352.namprd10.prod.outlook.com (2603:10b6:208:568::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 11:22:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 11:22:48 +0000
Date: Wed, 18 Jun 2025 12:22:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
Message-ID: <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a44f80-6f9a-462e-058b-08ddae5a746b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+UyTjckNQlH4IjSNyJgOhoAWZpP6/g6B6FckCNM1Mb/HTYT1NEQPcjJTha3Q?=
 =?us-ascii?Q?bA0yDAl88WIRgmpCxIrgKMuJYJfUSzTh14lYwEhXDMYxf8m2H4cUtoe9grvw?=
 =?us-ascii?Q?sZKtMLXZKlv/nBOnPpE9R0+1W4LS+TJxWgPAUiKUM5/WjCgqhlYr73MuNzkV?=
 =?us-ascii?Q?TAiz5vxM+4/zkXTYaCyRu5N7hwjZz+e/p+pp8npYwqLlKbYSQ9fis+AbxFMW?=
 =?us-ascii?Q?GL61gqKUwlIZtBzk1xzatWxhJYNEZjU9AINepJDLaquvUkeO5bLBEzw+NhjV?=
 =?us-ascii?Q?pGp9hIGmM6kbaRI5oAnyVJve6RqKAaR+HSi19zDl1Ebfd6UI4uN/tSvcvOMC?=
 =?us-ascii?Q?J1fep7W4GcqSVi5qpgUl0Vx6OuAWW6OLFYPNr3anDW8o8+BrRqD2841Jq7DB?=
 =?us-ascii?Q?bYt2Oqf3P8LA2N5XLnAH2+OdUCTqUh7ENsfoDJuMfZ4ty3wYZTj8q67vei68?=
 =?us-ascii?Q?yF6tXQE8QW5NJrZgdsxkKmhp79fm6mEfYly+zQStHSJToWgE4QnRjSYYsG5F?=
 =?us-ascii?Q?o6Q03ue1IL6hW1Egh3VDxEGzpTifr+57Vf8tIQYw1/IPiF/j7UfSInCjfq+R?=
 =?us-ascii?Q?n7NaVSoi0QTqZxkiz9Mg39WkEUVEwml53v2jg39kf9C7ohRvR3B9U1Rydg4p?=
 =?us-ascii?Q?Nram06wWBOCnHey9tIRZ0+1HKHYYPXLkjAO47I8DtZPFs02wkMRxUnWwW5wg?=
 =?us-ascii?Q?MuCSwcWEkTh1ByFKY5lpP9eyd0Q/hLZWZ3qj8fXWwhSRZu2cU2ezRUv83MRp?=
 =?us-ascii?Q?0hUgo4M6q/8u3bOZESZn0FlVwuJevjhFRMnzFtk7e0DDBLvpFAB3H17KRWZB?=
 =?us-ascii?Q?/tu1Z5kGrbjq9J66R8mr7WfjVQojj9EQ5A1AEbbhC7mMJk+PhVmX4mh1fcW9?=
 =?us-ascii?Q?sEwKqrZA/9hwTIj+9j6a722EbbJna+90HXAbJIaon3BzyPNOon6O6VXLwEQz?=
 =?us-ascii?Q?iEbVEG5MuBR0Vee6FPCqXWUpf8x229u3tstgabBbp7x+eOo153Tw1fJjeexq?=
 =?us-ascii?Q?Gw4NHZH9kT3eICT+Zuzi+E9Ml1Fea6XsK6ud945OqhMUx40IBplI0LThnE2e?=
 =?us-ascii?Q?IxRHPJKP4Y/OBSt9yzcSsbV7LNXrhqb553AKtUJ/SXLT7TR6umRrk9LZie3h?=
 =?us-ascii?Q?BsVfZmFQ89UW8hKhJPWL84Jf5M3r+TA/6Wtp+zAaJiMG1T57jHLdbTF2zmO5?=
 =?us-ascii?Q?LS4NY3EhsKNbd22WFM0HsoOdOBUD/52A6s6xVhRX2L91E3gKvbj0h58o5rG9?=
 =?us-ascii?Q?mGImcWfOCa1QXkIPFXPfIQK0nO8P8QKaZetYl6J3T4GDrT8gpp7imiCkQbby?=
 =?us-ascii?Q?lTNo1VoOml22o8h4wrTpxX0dqCNp8sZjG1xfdSk73ADG3OpnDsPZAvKIIfiF?=
 =?us-ascii?Q?E9j9E9B/RJZn25lJtxf/Dn/KHQ/twy7V2tfsD9RjMSU2446pQVZPxKsveWak?=
 =?us-ascii?Q?F+WeSmrbQNw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PteQI/m982kd94Lh014r5BYl5oKrrVXsEtClolahkxrtAZpD5xbbOeMmq9jW?=
 =?us-ascii?Q?WviXUmsu9sF9B7w/sYyYqe6Iflcwq4xRirKrrxKJiRvHqGZh7uv8zjVzQvdB?=
 =?us-ascii?Q?wF4p4y+1htMvnCwywVBG9Pdq0jIbhIsgjFs74URHVKpoUmvCIc/pZdQAForb?=
 =?us-ascii?Q?dyM2TbXjkcNnlc1BmcAYuYw4UrNPTGo8t98VCrvNbVUW5KXYzkmCD/MnDXE5?=
 =?us-ascii?Q?dFv7DrOLg2doJb5/0ijqxmrzTOJCqStwTvM0wvKClhZ7ZJfeaHR8WujIVpbQ?=
 =?us-ascii?Q?07EmUqaMQOkHCI2yCLiEI8BH5JQy/0DyddgwOc5QfEnVxQHi3NdjPQZxrzMM?=
 =?us-ascii?Q?wGYW3fqHEKti63mhMzI/mqgdBWEAl3aiWjgjzwsTX3n+n3BdC1ag0Up2kTF/?=
 =?us-ascii?Q?NAUP7gL3rX6veMug6ww5MwcYCcF6stE411NHis8+XFBWz6FG3BeM72vE83Kt?=
 =?us-ascii?Q?qiZ+2qe/KRk4Gx45ye+XghJ6Jdg+TFtNIAvt/UiVNRC42duT3R5y7HEaSoA5?=
 =?us-ascii?Q?AA5Sd0MvcMDUDqW4Jc2oC5n717YlxOBbMCnQjt1fUiwmiZafjg1OLwRi+KIU?=
 =?us-ascii?Q?mwkzXs2xXlYoZKPW8rkEWnhPKJj6W0SJArno+TVB1lE027V1PenLBwt6p3fV?=
 =?us-ascii?Q?5OYzrxLQGUhNGJXeA4V9mT4eXcLQ2wgN9Kn6dllEJz/a/TuXr/+WkAh+mW+j?=
 =?us-ascii?Q?O+VJYFPY+vhxGvrFybCTKUP2msHw5qnX0+e96NYP2sHVxEmB3kXccklBz9ds?=
 =?us-ascii?Q?P+rLPk/gByybh4tDrumIUItBAhIWoWlfl5j+Ar6QH9nVKXXGVQ/nOmDW4RbR?=
 =?us-ascii?Q?bpYK40pYLtuBa713jrEi7iRlv7KDEVchH3TRWvy6OEIBMRJ9SgWGkGhYfFEK?=
 =?us-ascii?Q?7tPvxGJV3jpyBJ6qY98JLQy1A8gJPP8qyb+bc6oULsMA10DFsGPne83KYP6l?=
 =?us-ascii?Q?xUENSQBbJIAekGbXgYI2HQz3OOGN763XktwdIlgfAanSdZpYN9dYgChZw24A?=
 =?us-ascii?Q?k1i93xIdbacS/AYbmPbLBe6vGv80fAvAmx9+egDTpCxM+yV+GAr4ybwVtu6s?=
 =?us-ascii?Q?FRP0+g6Lnp7qrv4oOgTr6Nuhapglk3KiSVzd/C1OnWRW2Nb/TYZioyApHlUt?=
 =?us-ascii?Q?c4Iww2LoONAOEBzmTS5BYwoAwbz6qDc6LAMB0xcndbN/U+qpyHjAZbnSliCV?=
 =?us-ascii?Q?GOOmHhGWMmk6EpURGFZEbxL7dYGbPdCyE+KDDfrZMA7BqE+tr2Ist+KFBJYM?=
 =?us-ascii?Q?UK1AYE0yzlTAhWOnPZkEbD/dQPDFVK66BtcyRSwNdIMkguxz+VHEzMuarYYA?=
 =?us-ascii?Q?+rNzaLhPCB0hfGgMh55X89MaPjjddFg9VXtUeGYKcsLkLoJ4YuCCKqyA3TUW?=
 =?us-ascii?Q?+IteqhwlsfH1gxbS9ozcrHdRcntLgdlkA3nrOt3mv3XxaLmaKgjvStF6lTjF?=
 =?us-ascii?Q?hseEgDbvWUEneohuI824WVemp2FeDQ+Tt3jvClUNqknYXu+2QKR9OL1+5TzD?=
 =?us-ascii?Q?z7xw11o1tCX4WiFOqk5qQWrFcXlpDKNPCn3wsYpHFlR7Cb+n69AMMHxY3p7k?=
 =?us-ascii?Q?N1yiPZBQ9AWlMytP3HcVxxAjxhNYz/NLT/km0O4WemfmeTU5ak5E2bRk5fyc?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ee8nml9AKjP9qSesgr9MLO+OFt/BlMH3L//f/sOevJl55Lkv+VOJmIF9XLvZKfM8MOoP/fHoekNUNj0bElj3ib6OkFJRoAUtdjVMElx+d62Co1xCdFsxs2nGCui6kkjjG685kx2JFIi0vcolycvar+q+E1lPl4u/O+gXT33WUU7ztXrYwlBGBkWXOotqL8chhgNdp8O4ai4qWCS/xEuQyJcwHcRu4JLUDOSfnoXvcGXO/6jTckSlrxPZGYUz5sfzgi4FBOh5q0DQDR7a7i0lIIt0Un9fVZulwfKMAOzBK0ebUegxy+upxq94UW1me707wDgo+egBeJ/dw99jJWJOR5UXR/zYAas3D4f4hk2190PdYEgewyysgAPOsGr7kRCeQ/3PHpWBirq9Wa2MLbxLtVIsrK+Kjb+w5PjgwYxMOfS8JWMLA5KnIztlW7I6oMOQqtg49mMcMG60l6RZzpoQK3nAHAk2arfGFfMXPstlVfjCVlqo3RiIrbg6sWV7hSFCKFMRRMs8Uuf7D0RYaOf/joqGcF5G/tv8KAstrNTXIY+mbZeGBaasgsix6wMwGc7hUU1JEXpd5Si+8YUbePqn3ztsRGKOwPn7dnx7cN19Bn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a44f80-6f9a-462e-058b-08ddae5a746b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:22:48.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMd+N49c/XKqFjKYwSSKTR2IYpuoefSWQKz3WLS8nfjCv9f3wCdTcQ/DQAkVYkbjnAQcF/Ve8wmxNIvhBBAZ5TTtZm68BdB79CMh91wOkyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180096
X-Proofpoint-GUID: UEvD92TWZ33BcA9TtRA1avmrg0Wh-kqJ
X-Proofpoint-ORIG-GUID: UEvD92TWZ33BcA9TtRA1avmrg0Wh-kqJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfXwPp2Peg455nf claC5VqcG/Zbm8rsq9OqxZgA93lk0SspG9eTxRzAEabi0pqe2X2z+Uk0iYt5Ccauht4CLfvaWCi keeus3s9PzC/Ygb7BL6geTDBfp+hwMmv52eyyCASiOKgUJRjtcwDj5uRQz8SOkGRBRtGRVIr2uA
 7vnxqZe7JMe8QQBgTUsZqwVWGW/ZhyMCDbDP+pMtyyRi7ii6Zd4axfvpMOL/f6HHZovAn6z6KnR AMrXzjDny80JOHUKiE5+pgypku6aEWjdUhlziT/Q/zeXrsCqVmTAO5KqXJBW094HN6z2EcMFE0+ UPiKfLNSi8ylzCLk0AZ/BkXsBRSN2On7FFrPMeWekyDxL0paBZCGy2aRmBY3++hW5QavV29Vemm
 WeFWFYHAGjP9bij88SN2Q/Ryc3fJhw9vD14fdL+7hR2FrQ8SW24foXsGsfIEhOCf56v5T9dx
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=6852a19d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=DERMO5hcqVLuv7IdAn8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206

On Mon, Jun 16, 2025 at 09:57:10PM +0530, Dev Jain wrote:
>
> On 16/06/25 9:36 pm, Aboorva Devarajan wrote:
> > From: Donet Tom <donettom@linux.ibm.com>
> > 3./proc/self/maps may not always have gaps smaller than MAP_CHUNK_SIZE.
> > The gap between the first high address mapping and the previous mapping
> > is not smaller than MAP_CHUNK_SIZE.
>
> For this, can't we just elide the check when we cross the high boundary?
> As I see it you are essentially nullifying the purpose of validate_complete_va_space;
> I had written that function so as to have an alternate way of checking VA exhaustion
> without relying on mmap correctness in a circular way.
>
> Btw @Lorenzo, validate_complete_va_space was written by me as my first patch ever for
> the Linux kernel : ) from the limited knowledge I have of VMA stuff, I guess the

:)

Mine was this utter triviality, but got me started :>)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1da1d573f67d11c2f80ffaf38d3cdd3fee97d4b

> only requirement for VMA alignment is PAGE_SIZE in this test, therefore, the only
> check required is that the gap between two VMAs should be at least MAP_CHUNK_SIZE?
> Or can such a gap still exist even when the VA has been exhausted?

VMAs are mapped at page granularity, the logic as to placement is determined by
the get unmapped area logic, for instance mm_get_unmapped_area_vmflags().

Unless a compatibility flag is set it'll be determined top-down.

I try to avoid thinking about 32-bit kernels at all so meh to all that :)

You get arch-specific stuff in arch_get_unmapped_area_topdown().

But the generic shared stuff is in vm_unmapped_area(), typically,
unmapped_area_topdown().

TL;DR, aside from arch stuff, the stack guard gap is the main additional
requirement, which puts (by default) 256 pages between an expanding stack and
the start of a new mapping. Which is 1 GB :) which maybe is why you chose this
value for MAP_CHUNK_SIZE?

For shadow stack we also have a 4 KB requirement. But only on x86-64 :)

Anyway I'm not sure there's huge value in sort of writing a test that too
closely mimics the code it is testing. Setting broad expections (which I presume
this test does) is better.

