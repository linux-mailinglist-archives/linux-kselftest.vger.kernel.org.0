Return-Path: <linux-kselftest+bounces-4339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED0684DE4E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 11:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF431F226B6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96686DCFB;
	Thu,  8 Feb 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j12vTbtN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O6IzqTqu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57D6A347;
	Thu,  8 Feb 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388172; cv=fail; b=ZUseRE5AzRRFIO6au/Qe0lwZ9sjmC3/EgR/+zDz09+XjRCeCNnzUE+W4whhXQRLIAhDC34MHBGJuHFAukXENP15nRKUaKB4TCOJv0KB6BLiJCoxWdDSwbgA3kQCihA4rdoRZMr3ng7UvKFKi7yp6TqtjGpDAdD+rbS+qmqyvtEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388172; c=relaxed/simple;
	bh=htr8UjsZyVdhFQI1WLRJEMGFwuJosvRE2zYWDDvwKb0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kPD+kisJ791g+qzOOPZi9LLjwGNr6w14uTuacf5cKmfiqk083zJrytUKsslJgxac3tfAcvAflKIUslHMqt09I5wqVHgF21xZn/ZoYsGpmnHHOCcAV6d24wlbjkxhKVpGwSGRCMEqkpuYzmFvMumIBziLyJcnjjya+nCF4mRlNik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j12vTbtN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O6IzqTqu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4188wwup017741;
	Thu, 8 Feb 2024 10:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EJNVKA0l1YPX86LKZhxlu4ZCZfQET5qsbIMthETyd7Q=;
 b=j12vTbtNzLPcN1nSTmY3ARvC3BJdieKnWH1vdnhXJOt/FyVCZ8bhM/ySXczIns09Vap1
 3gJrA/MJgikA62MrhMzu9snfLKcp60LU59ivnE05ZFgbgAkQH33EaKJhapzsdZEYXnnH
 clivmZaUn65XLmUrOR987Vi0dK3xrkm2ehYxsMKEv4AO3KzYcZEyVWz0mdk6Gwwzygaa
 73VQ0OqzlppYgy3QjACDDUPyG6Tmy4FDelI9SPMgCt+5n0shS656bg47dAeCVIT+U3Az
 1KFbHKzjQkueZTsm0xud+kEOiT925p+z2szgWD2VleQI1jlNp3tk/9sVzuI86CHc60P/ Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c944c7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:29:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418AKSDH036828;
	Thu, 8 Feb 2024 10:29:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxaeser-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTevrpl9IJr00+zIZ5ma6LTNR6WbnK/+aHTyN3bfpe7zrvcVH2BptmzGecxIy4O+d9UE/4jXpniV7zTiNvCuyxFL9sX6BIsXffYJBpbrc3otfPelWKqLFag8bWmsGvxg/aDzyerC9MR3ZJN+nMu6OzcieGun+7x9fBuhsnuAtTmOw2S5H9zCBITDlVExoQLaYJ1XYEbl/pklSPm4evpaWepu44MHvrOMPxhkieh6GVeOx3PPYiI/U1QAb+14dmV+v77aJeu2McQ24+ZASe7V+puBkshhDUq2H0oMhw5ibVd7Wqx0Y2g7lNPDSrd1wYfbqjNsBcHD7eNhhPqpTI4uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJNVKA0l1YPX86LKZhxlu4ZCZfQET5qsbIMthETyd7Q=;
 b=fJLEeWURbrf8CEOvpENO2fiFu3o3odYI99ptGzYfdr9V40sAx12l7gaeqTGReiR+EZh3iTGMcGqRZ4i0lOcpX8WqZW2BuuPosUHkQpJzokoNvTLoVXwV49i9teJg22i7LsKGQrye+4JbaHoWhD1GzsvS7R10RvR13cK3SqpedARcBv0gwUlmZTkvAtmTkSMgTrtzjMBXOy+nPX56dz1Zv44HgPLhqQ+kBj9c4QmIgLu8uOjkDp/KtjZj90CJG2cSFQUtfihwRBOOGzuK/sb22ijybK62WnnrAh5J0yeuwZQBeAkLtvZEyczPH9x6Ly+0xng6dhhbM3x/bDznvwBvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJNVKA0l1YPX86LKZhxlu4ZCZfQET5qsbIMthETyd7Q=;
 b=O6IzqTqu3QzA1795C+Fz8Le3nZ9dUh5GiUGohvghHC8geeIRIKrHuRX60cCJ62DcbavEKvH+xSHwgsNOq/3+BcPrIBc6zng4itUPRGibUYOf0F8nWvMdR9CgA+9vCyWRCtFESHoo+uFjrylbMP/9cIehedyFkPlCY7BjmLdSBq8=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BY5PR10MB4260.namprd10.prod.outlook.com (2603:10b6:a03:202::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 10:29:12 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7249.041; Thu, 8 Feb 2024
 10:29:12 +0000
Message-ID: <9cc25d3b-58d1-4f87-ac68-0aa0310297e6@oracle.com>
Date: Thu, 8 Feb 2024 10:29:04 +0000
Subject: Re: [PATCH rc 6/8] iommu/vt-d: Remove @domain parameter from
 intel_pasid_setup_dirty_tracking()
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>
Cc: alex.williamson@redhat.com, robin.murphy@arm.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joro@8bytes.org, jgg@nvidia.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-7-yi.l.liu@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240208082307.15759-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BY5PR10MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 813d2caf-eb79-43e1-98ee-08dc2890ca76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nqNm/l1CXqyM0yhCaw7GOziL2PW2kpW9slE+ZQM1f8MZdLMOU2VaDbrbS4feSVaupvoTuU0AdwndBFWT5Meau5Bb0A6IvqXQ5lRSpsleUuK5STVismkG9xxvEytJhtlFyNv7XsQwLHE3ev8TUOcKiNwY3mj+1nJ/ydntzRDkitFAzYjWIZD0G7JI8yLPElgS+MWAx45LgcnJJn/7L9v71kEONPXqndNw7vEHbtVHCsf8oyVcGZxb888Q6q7i9OXMuxdDKOXpJcKcN3WkOuXj7xYx2JVR6+zjHfcmSQb5JvM7wx6MqbqZP3O/hH0znOcLxkvWs7+cimu0qirkV5tXSV0leutW3Eoa3qwCN1BR12Yk3OduBXnz1NeLwi3YnG8cPE34nPby/AmftgfZerw9GsxaaF/F6son4v2JTIff/RtT9Za8yzRj7e1ioUF5zkM2sin4QxW4AREdiBdNnmIecUsom2EjPq9CaEKrQJzILRb8qVAwRkeg2pkg8Ur/ACutjRkD67+zxs3lvN7787bmz3Y0MSz26Rn1xgqB3nTjqt89AzJX3TNPiUT5RGcQDlBd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(5660300002)(7416002)(31686004)(83380400001)(31696002)(26005)(2616005)(38100700002)(86362001)(6506007)(6512007)(53546011)(6916009)(8936002)(478600001)(316002)(6666004)(36756003)(41300700001)(6486002)(66556008)(66946007)(66476007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVhPVnlJdU93UHA5cC9ubklRL256UXh2cTZZdW9hTDIyY0JvWDh5aVQyWTBR?=
 =?utf-8?B?cmNjSURPakVLNmdEVTBkWldFNEd1TU9BS1JkOUpzSm16QVBWcXhtclRsUlI3?=
 =?utf-8?B?RTlFVHc0NUx0UzcwcERDL2RRQ3JNSDVnZzVLdG5ldDlZRFdBRWZ0WktkSXpN?=
 =?utf-8?B?aVZyYUxIKzRLTFlsdXpDZjlOZFRoSmFISEUvc215VnkvVjFRTGp0ZHJyUUd5?=
 =?utf-8?B?Yk55S3lIeGdHenZia01TZVpBb1p6Ni9FODFTbUZiMmdjUHRWZDNyQzI3SUcz?=
 =?utf-8?B?N0gxUDZ2YnZ3MmY3c1EwejRmSUVSYk4vNzN3d2pCU1g1QUNETEdXeW1YRUJ3?=
 =?utf-8?B?UWJ1VFNpaHVMejFnVWMyWkNURUVHREdhdWpkQzUrSUdRbWU3cTY4OWdWaFA3?=
 =?utf-8?B?Szc3RXJrNGdYTFg2ckJJS0ljOVAzZnJkeWJ0cFRQTkl4Tk93NDBCeEJ2MG5S?=
 =?utf-8?B?QmVDNEUzaWJNQXlKNlZnSDQxdjhIU0xYNVcrWFp3QzF0aUxkWTBSK29GM3FK?=
 =?utf-8?B?emZMVE1BTjhyNEN1djluUitmVE9tRy9Db003NGhYTjZ0ZkZtMDhJa1M0V0l4?=
 =?utf-8?B?US9oM3NlWlZoMmZGZlpabDFmZjBvRnJnNEJ5TzcxMmtFcWtyQy8wLzNFU2dS?=
 =?utf-8?B?L0FTZmNoYmdTbUQrNEZYclQvRktLc0lMdXp5K0Z5VFJZV25FaWtra0swaFhr?=
 =?utf-8?B?dDdLb2VQekpyYThlRWVDazFCRHBnUklEamFWczVoTzJRcTIrOFhKMTNScTNi?=
 =?utf-8?B?UGtPZTZvZmNPSmE3LzZRcFN5RVdQZVROZlJoSEt2S2F6T0lWK2tHZ3NGOVp2?=
 =?utf-8?B?YkJxVDNaUkl6cHNHOFR3MENIN2l3YzRrRWZFTGJPUWllcHdXMk5YdUNhbGpQ?=
 =?utf-8?B?aFU0Njl3YUsxVDhabUdRMTJleEZTSmN1bHVRTVloZnlkZFB2RCthbzZxWUdM?=
 =?utf-8?B?M3hrdnpBeHlwNVRnTlVGYkVVcURLUnI2cVNPMlB1SWNKVTkyYXlzakVXOEpH?=
 =?utf-8?B?Ykd0WUh5SG43QkZRRjh5SjFadEZNMGFvN3VRblQ0NUFJdHI2V2VhY2NjYXJo?=
 =?utf-8?B?T0ZOMlZPTFJQK09Lc3pGSHFxTXNOL3pJR2pSL0o2b2dwUkxXb1ZMQUh4RnNT?=
 =?utf-8?B?MFU5YnByajJTbk9zcUJqWTNxTDZDRER5Vm1rQTlQd0JVK2dQNms4RGpreHdZ?=
 =?utf-8?B?cEhnU1YvNW9ienlTK2dvU0tFdzlhSlduY1RQRTEwakJveXVJNTBLby9kVnA0?=
 =?utf-8?B?K0VTajg5MDBycHBYa0JWZ1B6QUVIdTk1TlhUZUsvWEoxWG4zTEg5OWgxczU5?=
 =?utf-8?B?M3hpTDBhenZNUjQ2ZTNhTnVTOVArak94R0IxWTJjZStESkRDZTJXNjFDdGpH?=
 =?utf-8?B?T0k3OWlWR0JTNUwxaW1xMko2Sk4yMGdSRzlNeW5GbzBQVVpIaHdJTDBlTWgz?=
 =?utf-8?B?TDI1NlBNVGd3Qy9pTjdiek5PZHREWWN4cXUyeHlOVEI0ZWNNeE9LcjlHNCs0?=
 =?utf-8?B?UTd0SHNnZU5qRVIveHBCbGdkaVFYbUNYMkFZMXo4LzA4Y2IwNG9MbEtlWlBq?=
 =?utf-8?B?THpPdU9SV2g2dE1VRjBZcm9CdHQ5ck9yV3pGVmdsZmFsWTVIOHlrMVUwaGxx?=
 =?utf-8?B?S2hrMFhXdXplNk1PSFVJSjJPMFRBcXhBcUViNCsyRUI4dWl4eHlVc2xBcXNN?=
 =?utf-8?B?UlRkc2poVU1LMVc0SmlyYXdFb1kvNFp6d2tvV2djMUM1Nm5Dd0doNUtHOEVL?=
 =?utf-8?B?UU5pdWJMRHBqb1daU1YwYjRaa3ZUVzI0cmJkUzhFSjZTanhaQUc4V3Voc1ZY?=
 =?utf-8?B?NERFZVJubkFCL3ZLMXV0SlloMTJ0cHF6VXp2YlQ0dXpGVGR0TFFmeWJmejFD?=
 =?utf-8?B?MjIzbDRYNGdua2VBNkdWM0JrZWZkTEhhSzJaMU5rcStqeUo0cDVsZ0tvdWhk?=
 =?utf-8?B?NDVZZlZqZXU3S25GT3pZUmtMN2FuNXVnanpydEtqZ2tCZ0QrOFVGZEo5OHM2?=
 =?utf-8?B?czFTRzd3clpSTmtFU1V3TG5xVUZaZ3U1b1lFSUo5cklibG9XaXZJVW5CMGJV?=
 =?utf-8?B?c1BYVGlCcnhSeUlFbmFabVlkdjZMK3pZTzIrQXEvMXlvSDY5aXVPRmlwT1Vs?=
 =?utf-8?B?TlhWU3QwYjZ2d21rRGVTM2I2WHBsZ3JYMHRyMUlieWhGWlVvNGtZaWtwc1Q4?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uSZ661dglNrbYOMs7agg1djvQUHOuGrIFIp6tNTQVkLEI8+FsJq160kmVtsPPGnoBMtGi6zhayXzkBOIZYhHGcgyhxMLtBNQyY3QmpnRvdF67iCEdMqTdTy2pn/6ser/igjKKKJViG7TE+78/270pAfz2IKSM8DXDl5FAEDHzOuds0chcRkgmn71NjSMMVapZNejXTlhKOX4AfsvaaBd6Ds2Ur8+0/Caumh/F09/5seWh7/DyuYFP1HjsAkpO0+aHvYjfsF37YRarm+e08fI4cWGKkiWMtl9U8WYeKZD8hTozM4q6/NLQG12PNWM52iNiozRx/Ys0JO3gKcD3G8BRX+T4/xBPpXgZKg6pMXTId3qoG3jeUCW6xthDg3dwebmrjFb+kI7vinT094+GYItt8LZja0c1ykDy7pt2UuUG9meEJDHnmtHy6Plog6DBsB8OjjEWKRJAz8/8A1Mthr+4gYXPXMoHUF5hPBarry42hBJAwddwW5JXuq7onpW+4pppqgND9YdYAexquzQQDhJssU2Bdn9NB9gmMIPX8Y5XQTtn6CO01oWjgVW0Wt+0nldgqYsWZDbyoDSE9yazDxSqnM0b/2Yc/F+GB0p2MH4HMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813d2caf-eb79-43e1-98ee-08dc2890ca76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 10:29:11.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8mV7V0zv0MNw8Wke2rN9Qzf51cpVIDaWIK2XLz/72Pbt8Lrl2bUjzzePMhg/Bt8swlGzsLW+t+Gb0ub+WMaiEkeNvittl9+pxiTlUBZxto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080054
X-Proofpoint-ORIG-GUID: zqnH8P4LnUK2JbNPwcJ-8olVdevFl3do
X-Proofpoint-GUID: zqnH8P4LnUK2JbNPwcJ-8olVdevFl3do

On 08/02/2024 08:23, Yi Liu wrote:
> The only usage of input @domain is to get the domain id (DID) to flush
> cache after setting dirty tracking. However, DID can be obtained from
> the pasid entry. So no need to pass in domain. This can make this helper
> cleaner when adding the missing dirty tracking for the parent domain,
> which needs to use the DID of nested domain.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  drivers/iommu/intel/iommu.c | 7 +++----
>  drivers/iommu/intel/pasid.c | 3 +--
>  drivers/iommu/intel/pasid.h | 1 -
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c5a0275697cb..dae20991e036 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4742,8 +4742,7 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
>  		goto out_unlock;
>  
>  	list_for_each_entry(info, &dmar_domain->devices, link) {
> -		ret = intel_pasid_setup_dirty_tracking(info->iommu,
> -						       info->domain, info->dev,
> +		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
>  						       IOMMU_NO_PASID, enable);
>  		if (ret)
>  			goto err_unwind;
> @@ -4757,8 +4756,8 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
>  
>  err_unwind:
>  	list_for_each_entry(info, &dmar_domain->devices, link)
> -		intel_pasid_setup_dirty_tracking(info->iommu, dmar_domain,
> -						 info->dev, IOMMU_NO_PASID,
> +		intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
> +						 IOMMU_NO_PASID,
>  						 dmar_domain->dirty_tracking);
>  	spin_unlock(&dmar_domain->lock);
>  	return ret;
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3239cefa4c33..a32d7e509842 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -428,7 +428,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>   * Set up dirty tracking on a second only or nested translation type.
>   */
>  int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
> -				     struct dmar_domain *domain,
>  				     struct device *dev, u32 pasid,
>  				     bool enabled)
>  {
> @@ -445,7 +444,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
>  		return -ENODEV;
>  	}
>  
> -	did = domain_id_iommu(domain, iommu);
> +	did = pasid_get_domain_id(pte);
>  	pgtt = pasid_pte_get_pgtt(pte);
>  	if (pgtt != PASID_ENTRY_PGTT_SL_ONLY &&
>  	    pgtt != PASID_ENTRY_PGTT_NESTED) {
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index 8d40d4c66e31..487ede039bdd 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -307,7 +307,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
>  				   struct device *dev, u32 pasid);
>  int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
> -				     struct dmar_domain *domain,
>  				     struct device *dev, u32 pasid,
>  				     bool enabled);
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,


