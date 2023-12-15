Return-Path: <linux-kselftest+bounces-2078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7F814C8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499BF1C233F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A97A3C46B;
	Fri, 15 Dec 2023 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KPXbA2M3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1BB3C48A;
	Fri, 15 Dec 2023 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia6+xWWSIyN/KeV+6/3nfR29JHrwH6cIijPAPV4Bs4rN6/mxU3j6Ofxsh2uxlzEr2oyf+HAg7eOisksn2qi8r9wPyPgU4dC64LGzsjaXlcO82mMLfotI9YlPYC4uZX+plhuB5hfDQF0K/a7G1oHteLAI5bCppdNZe+nJEnPfGAFvwTWBKKdhwuL3eBy3YUhpXdYi2Sz2pJ385fAn08Fk5/m5jzmVVbrf3eitl7MeHhzHUJ6/IZ80kMx+bT+LEoyM9HM/bkIk6Ba/5tAuFqLVsdhyupVUJUYVI/RVa8AGGScADfg+cAjhMQjjSXA/Diz43rpF669rGl6wbHtv0Ma/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPSIrYGK70h/CGaxXzAxwOwzuq0/IBKsfnAxN2tq6rA=;
 b=JhVSNY5I9z8MjHvhHbW1oZUiEmFeQaiu6BHJPbEFgv4etPENAnDxlOrkyCd18ajH78x6Hgs3ykWpqZGUi7xajHvUu+Wycov1yADbHqbJzgFVYDJLg6mrTXbeKUbN9J7FwG4nT4oGNSh4RknMTbFATuIRQvnepRgc7ZvMe6jj9BMMZZULtUEjjKlrUvHZZTwnIMwScxfGCOICxB/SS2G5SWzY6GZVa9hvM4FAbP5wPxF67uRTMNTKVnWQrvjou5vIizlxTzqkS7K/ECRBcAhm24+N4aXTKnUVvE60hqjMtDoht3vL32zFIEmDHcYB9o+vlE5JCz+soS0HpZ7CYFDwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPSIrYGK70h/CGaxXzAxwOwzuq0/IBKsfnAxN2tq6rA=;
 b=KPXbA2M33FWWmCfrwy4aHW7/W9nnwr2oON81SbDdCoeDnf0bf/7czfEUDHDrCBQxPPd8w4XKF6WVQiD6RODYmmTRe5XXafJ8xgfmp/3kObGM4m8vKhZmE/Q5Vj9/6z35DjHbBqGfftvQKdM0MmwyjFeEu1YvLrdzzfd6uY+ZgEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:10:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 16:10:07 +0000
Date: Fri, 15 Dec 2023 18:10:03 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 03/10] net: ethernet: am65-cpsw: Build
 am65-cpsw-qos only if required
Message-ID: <20231215161003.jqjqdu77b5ihrpbi@skbuf>
References: <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-4-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215132048.43727-4-rogerq@kernel.org>
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: e61daaa3-427b-4469-bbcd-08dbfd884e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tln2pWgcj/r7RFnsbodTOU342PGmJiBQhQFZM6KNg8/hZBdmmVKyalMC5yp9CdlNmHXd6uDR1yruFXg2fxBbvj9L0papc5AZ8ytb3rrnpf47hLe+b6dNKr1FIKnH0zD5kQ7UYh7AnkT07b/FNI0IpGQ1U/b4yXOGNYdO+caMS4nT1irn4rNO37lJn7/sd1YCmR++ote+feQfPQJxXtgELh9L5b3iX7HSa+dnLOmgTgZ2C8xMn9GjlUdRr3x1mRweqFN5j4j9L+wJa4jKeDcICdmg2fvhmB1Q3Dqu3cgpOXHcPtvS99x3e0Z9kqpRciujshl2/Vb6BNzjBgW+vHX7/5yKUISAALPv2TmfMCfmxZ+bA4a47yS8AThANrG0NrI8XSIoKEbL6WU6WdGd+6wB6geMEIKLzgzMhDWZ5MG3VvWrAETWRZpSeD0iAj/R7vmDzSVftoqXCidyGwNxpj+dY0xBXPprQyN0PRKfXsZAQdq0UxLfWNuPrCFODIWnsaQFXbTBdgT+byh+udrse0PSkGt9JQm4CNPkgKhmhi3JJTk4hQCNfplE0f6LgoC6RGFC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(26005)(1076003)(558084003)(86362001)(6506007)(9686003)(6666004)(6512007)(478600001)(6916009)(316002)(66946007)(66556008)(66476007)(2906002)(7416002)(8936002)(4326008)(44832011)(8676002)(5660300002)(33716001)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VuwY/5Lwxur3sXbEAGtMvoK2GR4Oqf3oMDzfbcou+a9DxMbf0mHEvGCIGep+?=
 =?us-ascii?Q?cdSOlU2aSc1AXo1YBKuTPssrRU5bh/hOM2BHQHTGOh2KqpodIMmUAs+ZH8V1?=
 =?us-ascii?Q?7KPXs1OyhUpr91ISQuhFaHSwsdDHYaGvwMxD1G9ttGF5agxK/s+wR/6DjxBl?=
 =?us-ascii?Q?Nte0esZ7ij9e+LutQnSxrh16BYlGIFQyb2pgyKfvqrqeSYDc7GqCyorRrVbp?=
 =?us-ascii?Q?v5Giy+NDafap/i5gpVIK64TJkpnyHcUOy8I1FxkTs7Mb3F2OdANDY2Fb8Hps?=
 =?us-ascii?Q?jQSzbNC2WVo7bgB6BLUdZ4g878EGPfqHAyd8/v8r+yH7nbFx4dyseeaDjPtX?=
 =?us-ascii?Q?3dPDYcexTG0V32HASidtUi9tA7ZbSp5DJ4MHZegtwksIW+RuZG++Xwn8u4Wm?=
 =?us-ascii?Q?RDd8FSTlDBgXDWex5jYOUn27Rkkiv+OcX+GDEHCj4+inSouJ+AGB/BJnqff2?=
 =?us-ascii?Q?MAt+yFjFk9cS+kIHInl6CXWSWehEnLvsVG0+CFaMtTQ+eIjy/pK4Iw9+jlRt?=
 =?us-ascii?Q?OPEkoIRBx9QGJ7/MQUZuT5/15dqarlP5Rjs8RB75hM9pqKJVyb6Fxr0KBrc0?=
 =?us-ascii?Q?8y2d0qwv0tCkjo+mUU+PfG9FyWNhWeXIvdH5ArBxiLrmIY1+L1iCrE7+isET?=
 =?us-ascii?Q?MHwwcLjotDDZrHRzRKDuz2nY0Irb+/TPpnCSJPVeG1hKXoZBUvnEZmwcIXVw?=
 =?us-ascii?Q?rYiTceELWCAaTTOAujEGZsp/ekN5QFteuKQlqmek7t/kzhAfgfM1ib0EGb78?=
 =?us-ascii?Q?iGGFFHcCx1oDG4R3iZd2qR7uViHLdtT4xq36TIVMsT2Du7Zf0ZtIIuuT9Ker?=
 =?us-ascii?Q?W52J18Xk00tCx73ioZNt6nccsp+vzre2/Aq1USXZyWvbFRFnq8VzBIGyuywl?=
 =?us-ascii?Q?d5uTBUEIyBpUDRHntnKbhxJADoPb8bpF/4UHVxzqqjkShDmImUFze3EAEMMy?=
 =?us-ascii?Q?fA+ttjC61DFiwZxQPYKn5b9pm+crYB9ssk2qV2kcaH4Z7lLx1b7FSPTCpORQ?=
 =?us-ascii?Q?k89uCtMWJM8PIia366NdiSChDtgaKfThwtGvSDPSS7O+TZQm6x4RoWhuCODi?=
 =?us-ascii?Q?1otwq0bm0iRN4jyE6t5EEna/ZYyqZ1ePlz5k+lkUOzOPQ4MGcCpF1D5uPvTA?=
 =?us-ascii?Q?yv+565cJmLlNGGHfvUyZW6XddyCtuh8zlOAr4G2nBVifMGEfUsGbniL8Vpo0?=
 =?us-ascii?Q?s4YzuXd4EbzO1agdMed25bhLfTGU8qhyn8FsKN2UtqvGm4sOgZre+xxtakO+?=
 =?us-ascii?Q?Tdt46KLtHDSIfLEcQ4syArzs4KfpiafEVWwO/REEjN5COtYKAFSBAgAs/uhh?=
 =?us-ascii?Q?ZzILUKejo9ptk2YvXQjbvcip90my1y4SN/p08TYTSDLbuiUSzbv3KXWzeUDw?=
 =?us-ascii?Q?PBDgKmXzsr340KjYTLINUfvAxJkZDvlgVlMOCKhfUjR0SqUhBHSbOC8Ocxk8?=
 =?us-ascii?Q?wdVvzvDbWCqcXEheEJgOweL+SY2lxs6y+RmVyVzdhyfArx6Nyo16BhPEAKF2?=
 =?us-ascii?Q?AxQLWrqNqiIGuBI+Yauz1WUMYlIFCyvnTF5cTy7DxkM/DFQ0jo3UkGvq7Vut?=
 =?us-ascii?Q?oSKIZOt+UOkR8z98Eydzu88avsPFTQoWQZ2yaByOZ0Le2PlMYMLM0MkfA+oU?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61daaa3-427b-4469-bbcd-08dbfd884e43
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:10:07.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkmLLwWL9nC8G7k5yCdsbD5gVyZKp6tVhXJfxrzT60fSOxKJ51YBPplLifo/yMnKh0KOelnPm3FOB6DqhXzECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

On Fri, Dec 15, 2023 at 03:20:41PM +0200, Roger Quadros wrote:
> Build am65-cpsw-qos only if CONFIG_TI_AM65_CPSW_TAS is enabled.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

