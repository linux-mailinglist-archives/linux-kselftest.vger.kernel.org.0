Return-Path: <linux-kselftest+bounces-1444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E25380AB4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 18:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AD3281948
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0048405D0;
	Fri,  8 Dec 2023 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vj/6o5vO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="leKVbBGS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC01738;
	Fri,  8 Dec 2023 09:54:37 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8DNrmr015062;
	Fri, 8 Dec 2023 17:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=4oa3g8W3PzpoyhK3OXaDaytYbc9UcglW/PBetLTGnB4=;
 b=Vj/6o5vOzd3PHcow6aun1jxMgXZHN4tiGrrTL9oWYv7E6H01gt3FhkFovjEE+jCg7STa
 ypYv14UOtlU3GDkLs7rEJJ8C54eseDwdp8CRLowJzWoVDwypYRHgboebcnZaHaTqp2yj
 /ScT/0UINdpLsAOrOO78MdHVQALAjqwu9hl+6Qo7iE+FlFvjAawiGVUeUvQANtdPAQNg
 wKy5BP/QuDIZztJs/IOKdIpo87jc5xZFSiOCTDaoPhBt2238ph6nj+W8id4fISE6b6At
 a0Ho4rgoF9Ose/V68ZJ7m+tNrw8DxoeLmCWFFSOkCXttoKXFXatrVaYPzSj+hN4dDe7a HA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1ges35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 17:54:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8HTJlv040287;
	Fri, 8 Dec 2023 17:54:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanf7ga2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 17:54:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itydpTjbCTx/CEjXUBFCTQ5pa2buIPl/8XUII8yuv+NFGfFWd/wIP19oQnf8QcgwYO0aczyW5F51qi/5LAzRcwrisZQEVNsxklzklunbDWiORXWFnu6fczGK+zr5R76CdMXoBR759n8xlLd1gX0tTQX1dNKchfIW2oT1Rxz9WPsVt8JlVNmWEjJU/mDCSSJSCDfSv77HeB413TgOv+SDrY7yNbglepG33lV1xFGqXnH+VaTM+Qtdn/Gi0MgTkudeKT4el1OZ1dqREW37c1O0KdIZKsFAfEaSrbaVRCkv93tNacnm+6iT5bZZ26rIEo2Yt2H36q5XTXMKjSHBs5l6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oa3g8W3PzpoyhK3OXaDaytYbc9UcglW/PBetLTGnB4=;
 b=DeVl49/fQ9naMYC/4yPb4T9niDoMTpxbjwdpL0is6DbU+akhJVOjWPRp+/fgtP4HgN3n5Dtc+w5TurYCVi/lzb8bWP4afY5CxfvDfLJdOa4Onw+vc+aHoHw6EwAskraea6kaBqCSjxziBGJhHSICBzwbTeOfkO9OmZEzeMz8rk+6LHAC/lGMU1AHqIjsMo50PB/ATJUXOuRvwrIdBFGKvqypQeJTvrdCMrR1ktj0npTBbQU9Qs0yWoe5HKEudJw8pGqj/ac4wg2kWr8/BL8xP1FUcv6t4EF2R8nOYvsSTT2sZ2X2brWFBM5pbgxEW6Xz1Gg2BTssO6BBI04dqwsdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oa3g8W3PzpoyhK3OXaDaytYbc9UcglW/PBetLTGnB4=;
 b=leKVbBGS4RlgIiDzW1YOcA5lxyfmT/k+tFX/v5RyH8fjQIPu9jlA081fdq6+xJIqqyGOLEya9tVfGCLCZMih0OIczNfrBQvztQe5+YxH8qb7EOJMUH+aRedxbNnriLr96P6a34Z03blD714B7uKsxzvwYaO1jGldEGyG2bfjMe8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5752.namprd10.prod.outlook.com (2603:10b6:303:18d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Fri, 8 Dec
 2023 17:54:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 17:54:05 +0000
Date: Fri, 8 Dec 2023 12:54:02 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Eric Biederman <ebiederm@xmission.com>, linux-next@vger.kernel.org
Subject: Re: [PATCH] maple_tree: Fix mas_prev() state separation code
Message-ID: <20231208175402.hvy2htzs45oa5psx@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-kselftest@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	kft-triage@lists.linaro.org, regressions@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eric Biederman <ebiederm@xmission.com>, linux-next@vger.kernel.org
References: <20231207014104.n6vul2ylgqjnsfia@revolve>
 <20231207193319.4025462-1-Liam.Howlett@oracle.com>
 <202312071302.99D5B1BB76@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312071302.99D5B1BB76@keescook>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 4652afb2-d85b-4d9e-5807-08dbf816ab7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+Vt5Erlf6doOkW5y1E1rnz8upVHYfUPf4HxAHXvTPUvD7DYexNPp5WNZnuFSTvwQR5FgOZV2QEY6kFO9M0kGZQhP1+gHCcUSHbHCaElqRLYnVjoTB17fsPd+mMyWW3Kk56Xwr5OJxmJLrqS7OEh1AeNZniSLsqJs2ZCUZdGioiFAubWhcx7zPoQTJtDNUh6v+sTQP0RPj3ejWEmHB4BO9LfQXg1cjpvmYGQN2GTdNQtfXvZ1AFGHx2LES4xIpMKQfEIdHO0NPqiEnhf4PRnN4PCSr7FdL8OOwjlGxK9nZo57IOcLpvLx2x+bGX8We2Z4WVOxLsUyVhiIawGyRGFKc4gDEdnqMt+HwwzAtaH3IcsH6TDb4PO3usKyeJQQNS3Xoc48Ee0FOEjvwBLZcclzpnuuAkwCFzHq27+TUnSxZDMDySof9J76xbfHDHtL2rnNN1mkbbIgLCWb8TfXKlxGaIajnGHy56Q/LOQrJE/tNBUioy2VlWPkJ7jltP14Kxr7Zx9RLVJ2RBDAmD3/JL9GAzH7if6gDJoAH7pt2vR4Z1Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(1076003)(6506007)(9686003)(6512007)(26005)(83380400001)(33716001)(8936002)(8676002)(2906002)(41300700001)(4326008)(5660300002)(7416002)(66476007)(6916009)(316002)(66556008)(86362001)(54906003)(66946007)(478600001)(6666004)(6486002)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DvOs2WnHxYRg4dyoPmMZBJQ15vlg1xTK0Hs5ZAki2hOCEAvmvbJswA9bm9ds?=
 =?us-ascii?Q?6kdYneEj7gAO3ep7bpRxHcadlEJdu+lRiGvXbYU0czvxPak5lXi7PX2B0Lx0?=
 =?us-ascii?Q?ORNSItzi4CSPmKKidyOTFRQaoQIogXuVKkGLn7Y2X6oSHXBiNzUOEzVThuB4?=
 =?us-ascii?Q?m/IqLgUdERrxvirjWs2THpUA/U6eJxhruS3Ljpw9HbrIIdi/Dnu8qyq2P0/j?=
 =?us-ascii?Q?5gTeLSlSf+17rmr6lSOjKWl5aXWuNch0l/QQNuQ3Z7wsWNAiu3kQU15VkVP1?=
 =?us-ascii?Q?0qrhlE5HdmtY5PPodJlShZRtg/vodmR1h2Ja6VJSAidrOKssqtlnBycGQrc7?=
 =?us-ascii?Q?lYn3dSnt0du9F4RhLbGJqcD4vPZPUTbU1FtaAys3yUnF4QGDgWgxWD1XU17w?=
 =?us-ascii?Q?gKgZNr27ciEvdN5XkM7rofPX0rPooZJux811jyyL1x0NRynsN/PVFeTiiaGj?=
 =?us-ascii?Q?2SjFc+qZuvkv0GOwOclzFWIBfwL0FvjS+AkW4dtndpslm24i7wtzC4v4Yxxc?=
 =?us-ascii?Q?hYhHHtEGLusXbpB58UVKptjclOh/uZVd7tEiYFHZZtv2F4cZdBrbIJdTQ8jb?=
 =?us-ascii?Q?tzUv3LJDXwEtI3HDJ0/XuC4a3Zv5/yIFOV1DGCvYwvsBOfkB16V5xGp3gJsi?=
 =?us-ascii?Q?hlQg+8RddutlM1/Ayc06fAGh73jSzHyvGdpr7l2Y3QW4KnQrmkxJhDs1qQsj?=
 =?us-ascii?Q?CHtQ0xjlTXmPoQtQ593C/jvSUL0R8tPBmsL06uvH3mkwPLUCj/UlfzZmlgqf?=
 =?us-ascii?Q?X1Wxswr8XGbLPhbRyg8cs2gEwJ9hNYFNPEJty9JUvT+A/+XKeI+DKNerokkA?=
 =?us-ascii?Q?i5jrQW+eH3SoG5DN/N/M/ra8AhjdJsyMoAWQ+WX3QxlA3PBDEU/5CuBOaL3o?=
 =?us-ascii?Q?1LWF3SpPuHod3em5V6rgPucABc1Ug74JxUAVs7XkQDHwop0sGC8f5iirjFPE?=
 =?us-ascii?Q?LWoRwfGnTc5qvYYJ1iUGZQorjv1VeoJ7rH+HJ7jReKDgcYugyAcYizeV6OwI?=
 =?us-ascii?Q?u8R0YN7YIxba7aPStEN6CtnEsPutYNYPDqZeZRLn+niIIMp9dMSAFgUtnYrN?=
 =?us-ascii?Q?9UmhMlAJDfnyZrLTt8cUay6cmZcuQjimyEoPW7eoW3M4zwBFio7i+Cz8yGZ2?=
 =?us-ascii?Q?Ji+HI9B9qFHsH3MSlKaL4MqEeSAY3CKznyheF5RVEqv6JqHIr7gW5nnmw3ON?=
 =?us-ascii?Q?C5JjaKvyHAPAGLA+7JqUHH25h4CIM3IGHo4nVfwWqPD/KqmjPpd+9efMVp63?=
 =?us-ascii?Q?lZaPirGzKz0R4x5KYi5Al4wQB8js4v72hq1vtxrXMHsmnvcGWFEj6nGteLLY?=
 =?us-ascii?Q?eJAnD6nzTPKVt7x/GvbUZcRbGMjPOT32Ha3GpdRQKmLO+uKREKvmab8mfiKv?=
 =?us-ascii?Q?NZR2eJTLR9vjMAmeoKrmShdcn+xUqmMzNYrN1j6fXNHirFRrhxS3cyhD33i9?=
 =?us-ascii?Q?PJ5evRgPb9IpvmXLmv1a4uK04CqoWSJDoeHzM/CrLbEauldxS7J+AASTQ4+r?=
 =?us-ascii?Q?6B5wpIkax0S6bPd8TYkhKIaZ4iCuaP0mbKy7hU+41ehfqVRKCU8kfTtIcmty?=
 =?us-ascii?Q?iefXtka7Gkuh4ZnBlYOnGUxVDpedRl+/Ilbkoim1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?5I6eJVDrGytBeEqfKyNJSa8RSo38rkyy0tA0jIrvASo3LmOxe1Yu1I+Afhng?=
 =?us-ascii?Q?HTsDd9mgGqrr7VJc5kRvk5ooklR7kd0yrrREyr6aR/tzy2rRIdqPGoH65U7Z?=
 =?us-ascii?Q?l0kLngmMnS7XOsr3TnDZdQzQb5bslNDoKIBCG3uOs62nSA7LCt0aGKr1YRja?=
 =?us-ascii?Q?aTInFyM1LKJpS7q1Zy8txR2ucO6h5TEd6GKEmAM8Co4Xke3YyLUWFVWu6V7r?=
 =?us-ascii?Q?B3VKNvN1nHoWvJKuEyfy4gc23Epx/DuOJD0ZQsC2ODqt2gpPDWVmvQkfAp+5?=
 =?us-ascii?Q?9m5yQW3hhe3n3aENuDNXvEAP4DPFBm1tdB5m8wwIak0UwBQjTsAqehbMq2rt?=
 =?us-ascii?Q?Vf5NwkrYhQxQL/tOjL+QSqMA0IcYJ2KvzBzqCCYt6JTlbgILmlRwM6L7Vn5F?=
 =?us-ascii?Q?Gqf5Nu/VBigz6v6fZl7ADgDHOXS5fBOp9k/9fSrKzl0eXlJFbuIaogJ4HEbl?=
 =?us-ascii?Q?YBoqUNRMOLrldE/GxUiU+idTXeNepCnIOtJOPtHcjsr8Cok8ejq+rBsJbY4J?=
 =?us-ascii?Q?OtvdJsSvn8t7NInN8h2nXznYYGU/Soex8wvZXj4IFu4aid7TAYGWcb1PZ+yW?=
 =?us-ascii?Q?GWbk1KlQ1AlxV+hCY34tCCjPGSHl0rK3Q8vUcBw3wNRV2qoeBnE5rE2PNu4Q?=
 =?us-ascii?Q?1O70Xa0F5LZuMUKwLBIKBmn5HTI2wU/tyUw70jTaP++YGGxDbVnt0lFJLh9R?=
 =?us-ascii?Q?tG+uXK0yiD84obkBM2JIOWfqo9LUzL+2f/orukTdSHl+LEH5+TcpkPFnLPcY?=
 =?us-ascii?Q?sfEJSTlN+7YnNPZ7bgzBkIN4ZZ9HSEJSBnGJDHJbcpSAKl1hUDPofPOnHREd?=
 =?us-ascii?Q?wV+uqDNtC0dn/8iqDtQWmBDSWpGTbaDwif4L4MCaUMc8luDP2leLWLPw2XHf?=
 =?us-ascii?Q?mnr3TbzZq83w9ctj4fZnz3+875IXizdYbF07D4yb1AgUWFBsnAwIP57MXJss?=
 =?us-ascii?Q?Mcz8cZl3p4BhNcIAnbqTgI98OYZgKVTYopAmtjby45Pfms322zUTIwqTSrQm?=
 =?us-ascii?Q?q4MjtMpzUTKTznJbfqfJJCI9UhI5R1dOKTG7AeBxBkjSiSYcz5HZmTwv48UH?=
 =?us-ascii?Q?CMEw4gUy+snKTkP17pHC17/q6zyrkB/HxczYVNzSA97UYVXNUFIqLD1B/70u?=
 =?us-ascii?Q?X2ttCSEFot12?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4652afb2-d85b-4d9e-5807-08dbf816ab7f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 17:54:05.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EhxsrkIHnf13i4qaBqyNjBNDelfLQlIHTv5DQDXAkn6MhVY2v5YaR8DGLvMAJaL1FkOuLJ4gp4NvdT3DfYw6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080148
X-Proofpoint-ORIG-GUID: WH9UxD5ozggxI_0sRq2IZJ2AYYOdKHqC
X-Proofpoint-GUID: WH9UxD5ozggxI_0sRq2IZJ2AYYOdKHqC

* Kees Cook <keescook@chromium.org> [231207 16:04]:
> On Thu, Dec 07, 2023 at 02:33:19PM -0500, Liam R. Howlett wrote:
> > mas_prev() was setting the ma_underflow condition when the limit was
> > reached and not when the limit was attempting to go lower.  This
> > resulted in the incorrect behaviour on subsequent actions.
> > 
> > This commit fixes the status setting to only set ma_underflow when the
> > lower limit is attempted to be decremented, and modifies the testing to
> > ensure that's the case.
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> Is this is related to the report[1] I forwarded? If so, please add these tags
> too:
> 
>  Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>  Closes: https://lore.kernel.org/all/CA+G9fYs-j2FYZSFSVZj48mgoM9gQd4-7M2mu2Ez3D1DqDdW2bQ@mail.gmail.com/ [1]
> 

Ah, yes it is.  I missed these tags. Sorry about that.

I have another patch to send in regards to this area on the
mmap_region() side but it's less urgent.  I'll Cc you on that one as
well.


> Thanks either way!
> 
> -Kees
> 
> > ---
> > 
> > Andrew,
> > 
> > This should be clean to squash into 7f79fdb1d94d7 ("maple_tree: separate
> > ma_state node from status.") which is currently in your mm-unstable
> > branch.
> > 
> > Thanks,
> > Liam
> > 
> > 
> >  lib/maple_tree.c      | 16 ++++++++++++----
> >  lib/test_maple_tree.c |  9 +++++++--
> >  2 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 89f8d21602774..47f2a7a973852 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -4432,6 +4432,9 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
> >  		mas->last = mas->index - 1;
> >  		mas->index = mas_safe_min(mas, pivots, mas->offset);
> >  	} else  {
> > +		if (mas->index <= min)
> > +			goto underflow;
> > +
> >  		if (mas_prev_node(mas, min)) {
> >  			mas_rewalk(mas, save_point);
> >  			goto retry;
> > @@ -4452,15 +4455,15 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
> >  	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> >  		goto retry;
> >  
> > -	if (mas->index <= min)
> > -		mas->status = ma_underflow;
> >  
> >  	if (likely(entry))
> >  		return entry;
> >  
> >  	if (!empty) {
> > -		if (mas_is_underflow(mas))
> > +		if (mas->index <= min) {
> > +			mas->status = ma_underflow;
> >  			return NULL;
> > +		}
> >  
> >  		goto again;
> >  	}
> > @@ -4596,7 +4599,7 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
> >  		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> >  			goto retry;
> >  
> > -		if (pivot >= max) {
> > +		if (pivot >= max) { /* Was at the limit, next will extend beyond */
> >  			mas->status = ma_overflow;
> >  			return NULL;
> >  		}
> > @@ -4611,6 +4614,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
> >  		else
> >  			mas->last = mas->max;
> >  	} else  {
> > +		if (mas->last >= max) {
> > +			mas->status = ma_overflow;
> > +			return NULL;
> > +		}
> > +
> >  		if (mas_next_node(mas, node, max)) {
> >  			mas_rewalk(mas, save_point);
> >  			goto retry;
> > diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> > index 15fbeb788f3ac..29185ac5c727f 100644
> > --- a/lib/test_maple_tree.c
> > +++ b/lib/test_maple_tree.c
> > @@ -3294,8 +3294,8 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
> >  	MT_BUG_ON(mt, mas.last != 0x1500);
> >  	MT_BUG_ON(mt, !mas_is_active(&mas));
> >  
> > -	/* next:active ->active */
> > -	entry = mas_next(&mas, ULONG_MAX);
> > +	/* next:active ->active (spanning limit) */
> > +	entry = mas_next(&mas, 0x2100);
> >  	MT_BUG_ON(mt, entry != ptr2);
> >  	MT_BUG_ON(mt, mas.index != 0x2000);
> >  	MT_BUG_ON(mt, mas.last != 0x2500);
> > @@ -3360,6 +3360,11 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
> >  	MT_BUG_ON(mt, entry != ptr);
> >  	MT_BUG_ON(mt, mas.index != 0x1000);
> >  	MT_BUG_ON(mt, mas.last != 0x1500);
> > +	MT_BUG_ON(mt, !mas_is_active(&mas)); /* spanning limit */
> > +	entry = mas_prev(&mas, 0x1200); /* underflow */
> > +	MT_BUG_ON(mt, entry != NULL);
> > +	MT_BUG_ON(mt, mas.index != 0x1000);
> > +	MT_BUG_ON(mt, mas.last != 0x1500);
> >  	MT_BUG_ON(mt, !mas_is_underflow(&mas));
> >  
> >  	/* prev:underflow -> underflow (lower limit) spanning end range */
> > -- 
> > 2.40.1
> > 
> 
> -- 
> Kees Cook

