Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF65987BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbiHRPss (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbiHRPsq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 11:48:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D6D1CFCA;
        Thu, 18 Aug 2022 08:48:45 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IB47vk019207;
        Thu, 18 Aug 2022 08:48:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=4yp1TWuYt+/0j1zpuxUn+wrJZq/kbMlLflcmPc3R7eM=;
 b=fJTg5E2c5l6qZTLErMgXtwLAeiXlbXEoX7bUxTPVXRHeiIQUHxwyj3/aAsE/Opv5CzJv
 8HJaJNR0zyntpNBJRLE29fp2p27XTsVaMfhHf7PA/uOgtbEB2SLTaBX7deLOLSmuPMTF
 Mi15mucEreK2ZWIRa7cf1a2rRoEfaNKv6RU= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j1jqgj7yy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 08:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+4dLwOaTMgolPYN+DeBbSxYm8yBZPdtgHv/rH0jZTbC+MjR2ZctM9SF6LKddSCfZXJX4eCZLXNJFdvBPfa+WoVLh2AdNDF7ODKmj0tvzTE3DsfHYqNuE/xMMhoabVXwEhfG/33GtADPjYOSZ+od1lx1/SqnT3dYPCv2W71lE1E8o9A9ZMlXgg6rr0gZEykH/cgXVSYX9KmnvwtJ8MpUhvuF++0d/yvem5BkO5OrhtoPgOyLyNYUZe6Oi5UWK+S4jBx3WfsfBwuv/2mQAcnDAcyJg/7JlM6dvys4lBTOpBM1Q+MAAvJkuOqqTGyWPSPN1OGzcEtGuHjZU2xX+7JaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yp1TWuYt+/0j1zpuxUn+wrJZq/kbMlLflcmPc3R7eM=;
 b=I91uUfvk2h31VRfMx2e8NftcvmJDFh5pplGtOTN8V/ogNUGhjZyFu1WTEd4UvvV5tUIxxAeu4B8BLvsUEy6Ew7mPIAprlVzuaXY6VhI3i9Z1MBHtAFmyOiMPybDzNg7C3qDm9loJK1MfFP4ZHgzf6W4xyoFYCFrNBC74hwj5JyattJJTMsN0gdjMyuNwM3l9X28lsgMVMVLHttMNeYTIB4bnMZAtObsWoPIYF2CYAKb5S0zsKn/75Pmtl+OXBwK1wWniL1CE0h+E49FYK+CFbDR56DESEv0OKYPGl+OWFFnXDlpHp919P5ERVXPKwfo1v5uxYCuPOo7PFo08ZNsC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5262.namprd15.prod.outlook.com (2603:10b6:510:14d::6)
 by BYAPR15MB2328.namprd15.prod.outlook.com (2603:10b6:a02:8b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 15:48:41 +0000
Received: from PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::84f7:68ec:470e:288b]) by PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::84f7:68ec:470e:288b%6]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 15:48:41 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2][next] selftests/bpf: Fix spelling mistake "succesful"
 (kfunc_call.c)
Thread-Topic: [PATCH][V2][next] selftests/bpf: Fix spelling mistake
 "succesful" (kfunc_call.c)
Thread-Index: AQHYsoDlYGad7b1gdEGuM3HycxpVR620zvcA
Date:   Thu, 18 Aug 2022 15:48:40 +0000
Message-ID: <5455A1DB-B764-4823-BACB-FF4EF5134710@fb.com>
References: <20220817213242.101277-1-colin.i.king@gmail.com>
In-Reply-To: <20220817213242.101277-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c46b838c-0508-411b-d5a4-08da81311f9d
x-ms-traffictypediagnostic: BYAPR15MB2328:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2k+lyunAz7tpQjk65KIb0+z5T/XX7sDu+fFtdY1I2S1TBDYx+LT64f/IXwMlZmfd3sFiBZJ8pVHAYyfcXcCQaKIuSSzdAms1tG8h1rm3R92J6ab4FBDOOrYMkGmxc7XG1RTSxqbmHHIKqoemgCMGWd82C5bOpS3IrGkE/zs6zLUax7I5qQ9RM2uo3y9tBa2WgzhE7N1GTQpvXbz5UAuvWjduiFO3Y+Ux+E4DFEaY6EraAejVNjOf7oX+4bU0x5jQJG/QD58tS4Nx+N6yngW08WssWzA13xJXXEdLXgljZdd42ewdlsLXW+NYlb9yDW0CyWT4hosCDwkQuddqDWytoLiZnRZm+WYQddvEbMwuOpohQlVuWdB6OjDkJYRS0PWPpIBUV4tAi70gAxSpvs0F9A3V72C5P+YeVoX7PAzvGRJmixMY1NGh5EUjZolt+bUVH7e7ck7PM+sbyidhUzDyYiLNxZDl+pgsusRuljuwK24erYuRhg/dY62jIGPyy9xRzToatrocclKSzN+7KgmffHvAZuvrPEeXcs/7QSAr2xfvqx4D/CM7ufl8YxIBfEh6rgeEUBPb94rhrBfBuCnfpgdYuL9R2SjUE1W224FB6HxN1jMlyKqExjt+Wt84Hcgk89cd8pbTdJw+xM7elKTF4adH0TRijvxz+aIi6VrlLGSV8apwoUev4btUwD+W2FBgByo8zAUhAxRD2iYD7dRPtkmNldNC1AMNAXvXVQWx4dI+HFUj0xtZQixC9gcg3zuhJTmXWu+382+1tySz8YEhAd7FVnpHOE8R0tsREBi90ig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5262.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(186003)(6512007)(6506007)(2616005)(33656002)(38100700002)(53546011)(86362001)(38070700005)(122000001)(83380400001)(91956017)(71200400001)(7416002)(36756003)(8676002)(5660300002)(478600001)(66946007)(4326008)(8936002)(66476007)(66556008)(64756008)(2906002)(76116006)(66446008)(54906003)(41300700001)(6486002)(6916009)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yf1HWJwC7r6KtwSwao98JjskHGF/gPdS9ImKcsN7NMtgCHr74gNujh2we76R?=
 =?us-ascii?Q?yhq7c2IdLyxufdeLW18jUmycQUwew7F3eKwQAmw1Tday1/s6uuBrkfCslur3?=
 =?us-ascii?Q?4v8vj+quBGsJhT9zkzVkClDA/9JpBtzqHGfGQ7OpMsmmPR9+Y5imdyUItg4i?=
 =?us-ascii?Q?hm4HfdIMdlYOzp/9qstJXtJS48lBSP8LwuARNIhewmWx6glJJISikwdUYL0W?=
 =?us-ascii?Q?IgS4kfOI4lccWPMT/Wj3eGPZaLfgvbEEhCPTT5PuEqiW7y926rGg9PBiDkpK?=
 =?us-ascii?Q?XAZgdTxwAGbSama4bq0ANcOizv2j4A+e8Mmu6WnYJXKfe850B+BtL3A69EjB?=
 =?us-ascii?Q?LcR492bnYo7PXrIBj+emkXdQmDY7BTPxkEIMKwlCygqQYGu59waCVtL4OhpM?=
 =?us-ascii?Q?AdyWcu0d5H76FdWVTfaFIibjxXlZzdkQ6it5N5rnfVPc0QyGfJojyHgupiA1?=
 =?us-ascii?Q?776LVk5mPQxSqCWfv14fSbQmdHMV7Jpx+R2NFS8XJQ1HLMyKiYso9dOi6dvj?=
 =?us-ascii?Q?GUS+RndwzMw6XBAKI/kgr0tjB9VnaT8DuGLvKcoCWxF9pnXsQ/akKXzVQjSw?=
 =?us-ascii?Q?JtQZ3hQPq8BAoHYi7M314qNB2zb5EEEQqkz3owzu6x4NHJLbAAMUef7CSWxd?=
 =?us-ascii?Q?oiWgGmlr7BNHu40xnC6RplwQPJWoDb6Qdq7yO4L/2EhjoJ25nBFdwrwAt7fr?=
 =?us-ascii?Q?1O6qVpAt2o5I1UKTUjxskbPJ6VcJpuy6F57kaiqZvvKxrkfcqR9o3ZGab1Qy?=
 =?us-ascii?Q?rJCjKEha6xw4AaA4q1prXBF8ig9Am/oh6FH/fTph6U4lxzpMcFhkHiZMuM8V?=
 =?us-ascii?Q?/XZVQhIZfu3cEZ0PGLacIQvtdOERuYE2xXbjch7uwsvGrZk55RZN5bQqKO8L?=
 =?us-ascii?Q?Ui99ScRz/Hovssyv/dePOzt+d3cJDrYJha3Ltd3/nNbvDosGDmdVel94q8wj?=
 =?us-ascii?Q?raxqKuwaMRMyANMI/lhF/tnVuPXryW4gfjYatv2eXReDPsKuPsaGYhA/qTHy?=
 =?us-ascii?Q?jL4LHpe+eDmQsC/xPz00MZ4gflNUse7TXVKabjknE5fqR5TjuhFybHjf5dOp?=
 =?us-ascii?Q?HyXlZLFkMxlYASYCd7/ZZ++0q9EdlDumdByLuqxSPq9SvVe8p2/BI7seBydK?=
 =?us-ascii?Q?7J93vtQZaEtSpCr+gOMP6aeJreXtZYKSlf+NWcl1XnVxkxRsOc1de1DOpWGT?=
 =?us-ascii?Q?nVLjeHT1sAvaVLmNZL4sYtJplVdBAhl7wAqGWRv08EVldyuc5Mh/N4KaeQ0s?=
 =?us-ascii?Q?LdNq+WCmvBR8y89op3Vg2kr4E2rU5FTeuF+Xz6cOot9J0pqIwV/SzPTJXFQf?=
 =?us-ascii?Q?cvTAZbhsju0HysaZBcM6l2YywJhVIwAFlO1Gay9H1mneaM1RFUeVJVKHVJGA?=
 =?us-ascii?Q?UUJHd4SnwhZQta3s0m9WBOabYKger4uhH8HncRAe6kv1gFr+nWf7T8axJHTi?=
 =?us-ascii?Q?KfVvNFdcvO3QG7g+u9YSl8JMkg4JcNPn53utMQy8FjNs4JNEOmqtkyCEBXY1?=
 =?us-ascii?Q?juY4FWcuxLfDPNsxYbWYOPO5LWUgVMhsSPpSgqevvEyrRjaBJ31Et7awQfxM?=
 =?us-ascii?Q?TRBHDLj0sLprJLIPI1cG9DwAmfNKh+ZFwCdxaqAmHO6z8mtzgZUiB/NQsOFN?=
 =?us-ascii?Q?a6NZjBW4sN+zpeqSqCY84Jky3IulN+CGcagCLrq6Xe81?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D274C1A373CE840B9851E419754671A@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5262.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46b838c-0508-411b-d5a4-08da81311f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 15:48:41.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7BZhupaleESb8QDwyZQYh4UtnQ8WIvk7dZpQQYoQEq3nEga243hJQqeK5jrkdoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2328
X-Proofpoint-ORIG-GUID: MiuG90vNvjF1WNglrv9E3msqTZrsHI1z
X-Proofpoint-GUID: MiuG90vNvjF1WNglrv9E3msqTZrsHI1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Acked-by: Mykola Lysenko <mykolal@fb.com>

> On Aug 17, 2022, at 2:32 PM, Colin Ian King <colin.i.king@gmail.com> wrote:
> 
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> There is a spelling mistake in an ASSERT_OK literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: change subject line as per Mykola Lysenko's recommendation
> ---
> tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> index 351fafa006fb..eede7c304f86 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> @@ -109,7 +109,7 @@ static void test_destructive(void)
> {
> 	__u64 save_caps = 0;
> 
> -	ASSERT_OK(test_destructive_open_and_load(), "succesful_load");
> +	ASSERT_OK(test_destructive_open_and_load(), "successful_load");
> 
> 	if (!ASSERT_OK(cap_disable_effective(1ULL << CAP_SYS_BOOT, &save_caps), "drop_caps"))
> 		return;
> -- 
> 2.37.1
> 

