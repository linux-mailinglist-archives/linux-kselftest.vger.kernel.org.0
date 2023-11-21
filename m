Return-Path: <linux-kselftest+bounces-393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963D7F38DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 23:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA701C208E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE856447;
	Tue, 21 Nov 2023 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Mjmosxud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2038.outbound.protection.outlook.com [40.92.48.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A342A3C0A;
	Tue, 21 Nov 2023 14:04:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqROlfJ2TZbUq3rr39xx/doOiGyFupdPMuumIoMGM1EEaaacNCrIu+F3VzSnc685fkPlGyL4PKJ/fPogv+QJWzFi3ebq98x6CE6Te54rEY+kFYINlaPS+lGNG9gRApmuE998H5qcsug6g2djKDI86GCJJo2wvso7kH8Ys0VFuU23G5ome9rjMlw947nvvsO6LgrSWYOfBQoDEmABMNuwP/+E+mshqGx6F0ZzVxpjkeccyAJ6lKr8zTGTugI3o+CZVziYDsC3zyKRgV8LlN56NmzcgQaaCBzWmp0zeetVu576HYOPSeXheiW5O1Brd9V12RCzCoXusQl7eflyPck+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Mpxw1ESlYWIati3JK8aJuXqpkEJ3t+k9eoKtet8dpw=;
 b=KQlgbQiTDb/G2a/hnpaMXi2fZL7zG6FnEA0sU6CRRfBIrC3Btb4qIil/u6M/G41QNhvl2R7aeUTeL54rtx1Pnk8h/OpAnIFEMYapHavWTVyr+L85A8ZRcD3BBGyPDu139dD+qE/2fZfQXghPT+/Yt+mzhDjCHh8hhEr4Fv83juS9J4xftdlNzCvNIuhcqgPH6/X9vDmBNa+xbdb/kgO0OoLuZyOu+L4N/vwAVrbqL6I6TfX61VUqneIlLKlstjrs8sThWkvGaYVijHJVxcTwBuIwDqmOe4goaWwc0GZxfvdGIB2EVO73XtAjVSOQ/eqzDkn8NEKk+fagBQJmtHGXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Mpxw1ESlYWIati3JK8aJuXqpkEJ3t+k9eoKtet8dpw=;
 b=Mjmosxud8hdSYgKJYd9+Km72QoXYoNMpKAllUOJj7mX4KJ5zM8ZSe0mE+CBccWJMcalfbKvgsdpxjdikP6vO7PeUBL1Lm9RWKTzH7yNAihwLIF+3ByK2MIg+NFyBCafJwIo8Y0wAJJi9nywtk6th1eVwHEaBNoXDkEe/kJ3acD8L2QawZht1uz4KcjorUuBocJ1M0tGTNVGCu6DR8EsIO14Iy09qoqav1RGwArYTHToPkSSo9WtIPPnXlVmZJY1HsYaKBdXKMjPhmZGfhn9RhKImc2bXq06U0HM1eB8040GylP52T6iP3pb/72okUV5qrNkq6QUKXOH/6BXWFJmygw==
Received: from DU0PR10MB6558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::20)
 by AM0PR10MB3971.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:144::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 22:04:46 +0000
Received: from DU0PR10MB6558.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3f75:4763:843c:a330]) by DU0PR10MB6558.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3f75:4763:843c:a330%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 22:04:46 +0000
Date: Wed, 22 Nov 2023 03:34:29 +0530
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
	kpsingh@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev, mykolal@fb.com, sdf@google.com,
	shuah@kernel.org, song@kernel.org
Subject: Re: [PATCH bpf-next v3 0/4] selftests/bpf: Update multiple
 prog_tests to use ASSERT_ macros
Message-ID:
 <DU0PR10MB6558D41ADAD7B5B9CDB43CC2E8BBA@DU0PR10MB6558.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <11bf3c0f-f78b-4dd3-97d3-c39b5b2ae7bd@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11bf3c0f-f78b-4dd3-97d3-c39b5b2ae7bd@linux.dev>
X-TMN: [oKT/7LovT6WUlYTz9u2iJhY3GSaipBUh]
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To DU0PR10MB6558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::20)
X-Microsoft-Original-Message-ID: <20231121220429.GA465153@nmj-network>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB6558:EE_|AM0PR10MB3971:EE_
X-MS-Office365-Filtering-Correlation-Id: 573e870d-7b31-4312-072e-08dbeadddf4d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JloLnv/Vs6Dh0DxaR4H+iCZXIfMKUuwHdKLT1X7q7Pca9AckDi8uLeHRSPZ4MxvQgPZexz0uOyr/qjtKtMeyCxqFxO4fWPJMiQqvOqBS3nip4qDUiMsIj9iqeGr5By9/Fwqzg36nmRRKzWXqVzXKm6Npj8nnSgBvPWXHSYt+uTkMiDaa9YQa2uDb0u99FOzxnLyj8Snfppo4mUznkGFq+DmFKPItN7PP8fUyLnjWU4Zxq/mlTKwMClWs9YCJQGy/du8/GY7yGHYUod5XXVnSve6Ng/6kzDVP/uKN1VnNhlL7boYx3uq9jJ9CNK7SMbkUayFPp/zlpG2gsFMGncKfiTw7u6U5m6fm4FPWtb890RM05x0hU0wXLccuyr7ZsJl6sm8iDMUGZK6UrKeeXGHye2EdfSG10cHdBNcUGLSJ2b+EJ7ElHlNlI2XvM23VHrqrbIhXxNEnKVBot/UUL862eXi1YTA7oG8ghZUpGDacuwOXbk6ysV4i5aQbNyHHoLvQZilFXTX4FlPOe/1vh3S1U0L2gmqnf1kAsd29FaSJ+8VD90LCNZx/Mp1GZwxh+s1k
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1k4DTXusypQ5D1g6DMuyjUUpI0jT/fJU4opsKJ2U6t+Jz2y9HjnnCP9bm+8H?=
 =?us-ascii?Q?KyVZWyE+Ra9awzMWNJSUhPUFEK28DxuRTFPBol/T8/854ktmJGbi5uXWxJi+?=
 =?us-ascii?Q?gLl6S8yV9dbpEAuZBUFu+3U028WVZqPWTI8dXE2KVZXnYvelpjTmI3I6Baen?=
 =?us-ascii?Q?FhW8BZbdTJDpRun1BaVqgzQm1Kodbs/jqiFY87jDEEARuCJLj/BFzh1PKvZy?=
 =?us-ascii?Q?dV6IcXrSgQapH6i+5FB0qYzCCtC3JQY3aw8B6ToLM7QWRqJCUghV2UAEdYju?=
 =?us-ascii?Q?aGEnbYpcuddRvO/QToD3amAfbo3U5x6/TDr8Z1qShVyDi27QPVNK3k2pVD5m?=
 =?us-ascii?Q?y+aJqio9VS5YTsHfNkHsEeAerJXNj9dTthUcsi2KU9PNlsRKH8lQSLJgu5PL?=
 =?us-ascii?Q?r/CTwPBCQX6pcvPeOa1Pp1ZtOZa+ufI6lCk6CR6clvB5T0vesC/sp1qOSg1H?=
 =?us-ascii?Q?nwrZC+5mG3CeQszeGwoRAiKRsg1XxdoN7KQoSCbO/0vfKbIMbZLcORer5VOx?=
 =?us-ascii?Q?+kKR+GN7nRl/Ve88ygaaj7kKqprLU4o6PpvdikzcO6zGzcWm4iIZWS4avPWX?=
 =?us-ascii?Q?OGg/COw35XTN74xfmf6PrBmVKe6CqUnQ1/+cZV0QszArNfno6YaW1VUunAm6?=
 =?us-ascii?Q?9ncH9bu3bPTAPD/zkObw5Cx96fe74QKS0khzaGzP7PpZNRxAHRJG6rU58guE?=
 =?us-ascii?Q?Oq0/WvvrfuWQbdbInNKCBh83u6Zds20rq6D5SkRH61UtTEvQPVuJT83B0GTB?=
 =?us-ascii?Q?2x7jH1hNm5AtrMWK7IBp5Y3aZuFPZef2GiiSWQoj0M2hmBJGsqvubp9ifBSQ?=
 =?us-ascii?Q?lRv09HtGq86/BV+ZBUol4l7f09oOR3MLa8o/C+kk9+zID/3Tk0UMucwW4UUZ?=
 =?us-ascii?Q?VyQgHgcIaypPb379zzyF0m0Rm8OX5a2bHNIZd2wJCq2bE7gnEdGPUEjXljNT?=
 =?us-ascii?Q?ka0GKrp6XRkWd2UXfziq71VpopWwNVTCWenXNQ9ED4/wlyXUC90uJAFXBzKL?=
 =?us-ascii?Q?xxM9DAd0cCqlrCbMUegkaGWjS/2L1Q7XcHbBlFWsTUeu00ienHNxgF0f69i+?=
 =?us-ascii?Q?DF6G/9QU7qYJEl99OcACoPnP/FcDBlXepZJzaK+/SC48HEtIyN5rMZP3KBMo?=
 =?us-ascii?Q?IjdaMCQ8iTqbKVKPGD7oPqW+Q9genwVWhA8QnyAyX+eGUdFvq2C0uTnKTkbl?=
 =?us-ascii?Q?XRNOszSK0yOsXJG56wbOsNn8/jY7kWz8uDBLIagLgDCI0Xk52hLhNEhex2o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 573e870d-7b31-4312-072e-08dbeadddf4d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6558.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 22:04:46.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3971

On Mon, Nov 20, 2023 at 10:49:39PM -0800, Yonghong Song wrote:
> Yuran, next time when you submit patches, you can carry 'Acked-by' tag
> from previous revision if there are no significant changes. This will
> reduce some of reviewers and maintainers' work.
> 
Alright, I will keep that in mind in the future.

Thanks,
Yuran Pereira

