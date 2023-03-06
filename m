Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C636ACCB0
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 19:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCFSdm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 13:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCFSdk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 13:33:40 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9B46087;
        Mon,  6 Mar 2023 10:33:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmWOHzTPA29+M9biXwZyCoSfLuG7S4cHNaFKYgjLwwf6lDPKd8Ir5u0lrM+S0CcNARtkhLfpPppATt8Tau5CuaI58ORCyad9/7dW0E54tVqFuoBFoEKN+bBYpLONezyR9Z7UWm1F1So2VZFQewMZXtotUG6S3IyBIXjgIct7Bu2ZDhIxPQcKVzMacWow0IRq8Pczmx0/LdLXPF7JpKRl/LAW5qu6pzD4m5rrjAEpi2WlMI5EalYZEAhXMB+QsrKQ/eoKnZOMA+ELVHuT5s+RDK6FDQ8BCxaKNMLIMLTPuzcux8aIQxUgtDuBbHn4eZnHEL/fr9YKyzFfueSTUhpyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJZU8TERkCS6A3QpGK1dnqzrSpY9p0cXDPeMP3L2Gr0=;
 b=Lnlr0O+jaRLrHKmjYzEBIpCoQSAlSwPqZHcHN0rkg2kYL4e8Sq8NuF5V4G/+FZ3womqyfkj5WeEoxNusy2FPoKFrInB99QXmrUjaKjilx9IjydV7W2TESUtQ4yxFN5j6gowhN7gy4mBWJqaC31cwIuhCn2jjg5H+nzmLzr+AB9sbJvYaL6QeasYwaTwnls2LQICCz12SPBF0u06Zh2qZsfLvs3M/sub6NEFzka/YcEyO8VYhXtxKUhNJsbprTwNAItqTFlaR3+j48p+IntmBVROFDPvZsVbghyunAEaMw7iGWAVRTuCATjVicoQVVoGpvX3pSql7hWDjx1A8gAe/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJZU8TERkCS6A3QpGK1dnqzrSpY9p0cXDPeMP3L2Gr0=;
 b=ctLE2F5eVupo9ARGSOZh6zdns54p3+iAqLKPqDb1ncZ01UF3/zTghfcb7J9NWHIEMjOgBRKIxffAY4SAPtRJwyKAGyoBeXU8D6eW/btCTZkhpaZVb55M4gUE7c12BFfs9hUx0Q/aaVU3u4XhvJs20NkN99aB4xTw1r/sYCOXHiHKk76PL1yHIuMWTq9wa81/y+vQuZfrsnPZuRp+V6Y5cWKZj8COkVPVv0l9o2PGXDyy2srmJYNjIRrPF0zt18tKPCeg4DtPZIXdWLvm179gQLwJDgLTZBkQuzI78ipieO8buREZxC2vaZB1KByj9aOUOxd4wmt71O7/rT5D99U1jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 18:32:57 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7f2e:5e8:9129:8663]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7f2e:5e8:9129:8663%3]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 18:32:57 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/mm: fix split huge page tests
Date:   Mon, 06 Mar 2023 13:32:53 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <4B992776-098B-43B8-97B5-17856BCDD72E@nvidia.com>
In-Reply-To: <20230306183119.igudzgqj5bemqkox@google.com>
References: <20230306160907.16804-1-zi.yan@sent.com>
 <20230306183119.igudzgqj5bemqkox@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_8B7FE638-8DB7-41C6-B77A-F74B08567DBF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:208:234::8) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9d8462-2edc-4141-1296-08db1e7134eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9G+Qx10SPd4uKDTrRC754agMotRi22wFgHEKhA1U7/URwnJdUF67OURx+O6ta4cg+JaQV0Q+h+96AlKj0Qma9eaeQf8vWUTWVoLY0KuKQFjCnT713YrLYwoUfMrUWh3OEXm3h7OSO3YlHbBVPOl7HGOo2mhoTSqlwgduDtmPtxnGWeZx4TcQAPU+xL7EgwbXEg96n74oh16R8eMzB5hvz7V533Jb5mGcnvUrWL2V59sfVUY7bh0gePvmz/rBNw36qIivSufcOBSlUTSYg5focS1yLzldLTyEJqoAjGAbt5xxqfkNpWnr2AeMXASx+FqSRxhwUGrQjAEWGRlkgYUewHchWPGsm3zWAq8IHbBZVLJbQRBGOi0/lDfDY44nJCNP72vNTa0szcNovhuzFHDbrXhTfnDLmSJKWjVSADoNF/zsprhgHVTIqa7GcZIw0+rNnCvJUcTfA0S3oHLY/VybnwauyNm7ZUWvwk4UcWbO9Nxg8DPmycx7KaOa8TrFzPW8zVPwrTuDnTMFp0PfX7EkpZq1H57meMI1KhMaXoJtMyXfh90o2pvYfNnuQrEaMOAUsGcCg3Rqsc4KoMqh90i3Zn6UA08RZpyBDOhc9qLCwUxgEhNGB+KOV65F/VqVH7D8684sn2CcC5t4X6zzOW6fl9Rkt/LnHIO0TCTTvTEatyrwavlaQTLF4wvk+WydZ5+7x2wCRE7aCiLzcJA/L3Ahq9+ecedIJz18ADBXQ18aZPDvy9jyV1mu6uMQtzf+1IT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(6916009)(36756003)(33656002)(4326008)(66946007)(66476007)(41300700001)(66556008)(8676002)(8936002)(2906002)(235185007)(5660300002)(86362001)(38100700002)(6666004)(6486002)(478600001)(316002)(54906003)(83380400001)(6506007)(6512007)(2616005)(53546011)(186003)(26005)(14583001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44y/GdDTUx9MldDbpPvvjL+6l5vDh9EPmFgR8fE5qugaJi/haY8/Nxvmxt9e?=
 =?us-ascii?Q?E8wV6u1+W8P0Oc7UKTHOgtOZEJx0PTz+k9QWsGV9prphATZPvVgxSRGTXiAo?=
 =?us-ascii?Q?y/CYlD44vfPH03r1ZhN4xvjygJxVmwkS3KVvPmKL19a6vAALQBQ6JemzetDo?=
 =?us-ascii?Q?PwZiojPNwkTG/VMeXBENpBpdEVUUlrNd+2Iiq+hdcXavwjC/c0cIuAWrlBav?=
 =?us-ascii?Q?/pbaghyzUT94mH3Lt9/wV4XhvSelgYElINw1vrHA3LxFk2ELgd3F1pwH5+xl?=
 =?us-ascii?Q?LBd/wew5pbtfGadutXCc7WpO82AIfpVio9erRaestPaX6dqVERSjkZoTeMJK?=
 =?us-ascii?Q?Nb7kACsvHphPyy8Iq/bmZ0wOrk3iSMtG896qJJKR7IB34xHdZPsBZyK9W2CI?=
 =?us-ascii?Q?/1ic32KtUrdJaunsvuAfqysiZjA/dLfMhqCYGIZS+nIVqjbo2PhdApPwoyLp?=
 =?us-ascii?Q?Ut2kIGbAN2eIVInS8nOnsvmjuuzC4bKpKGGeZWh7GvdZFajZnTshbrjgHKhV?=
 =?us-ascii?Q?MzpbYpc60TLMbmZfzqLP2lURBoZk4KECB+/ulXp8WmwS/+7k/DmAopq3/l5y?=
 =?us-ascii?Q?AKg1dCzFDb0MJc/PuvItcNa+53fkY3Q6zIIPruZlXb8TkqPkti4khaxSPJh9?=
 =?us-ascii?Q?iZ7YeS8rmST0JNOLZXGF8zq4RhXS2oszUsPsf5IZFE4eca3kuoUGRd/FwCno?=
 =?us-ascii?Q?hFGyGRnp/MVpZCA0vtyCbWjZd1Sf8Lq82OdNpLVynyxPpWPSRvyF4aiSZIDN?=
 =?us-ascii?Q?oKfnfPxI4z1diDmbNYdZbRBcJOfS7QkEGSc2SUZDliASmPKb3b9oGz2nyeCB?=
 =?us-ascii?Q?W7GwekH7fbOOEE4bm3MXH0tlQ7lCXK1bBoaZ9kKmur7r2bnhtjqp9nSvSPP6?=
 =?us-ascii?Q?ziAaCNNzNsN0hd2Y200g3MO7vHwQKAEEVeRWO/PVfhxhl/4e1zxnwrIvuaY6?=
 =?us-ascii?Q?mrSVvLikfWguQq3Bx5bXzhg0OzF13PevcyhHmLOwKfu8bPHpFKxbMx4uoAWe?=
 =?us-ascii?Q?NfOvSyASeyau4nitbe0bPLFrMkZ8Q43xw0Yn4xw3EFWgMeefiHLkv36xhuh4?=
 =?us-ascii?Q?avXXoMqjPb3AFCfwFpbks3njLhc4IdMWRfO1lHDJiunANyIN8yogJUsBatJg?=
 =?us-ascii?Q?wCkov7nLu8azNReJ3K2hHN90ikKyh9ooVWSK67wVzshTmBHoQiZqAxKWXZUd?=
 =?us-ascii?Q?3hkky7Gh7xoHpHF3QrTWP7Eu1z412k/nQ+wVe/ipR7hSmYC/BuEewDqhSnOK?=
 =?us-ascii?Q?4+3hWr3GpfZXzhwNX2McDf314KV9nDQk3P9QucI82liVK7BeuwP5FvjdIevX?=
 =?us-ascii?Q?+4DLuMZkiIGom2H6AEhBZB1bEiZlZBs6krqtSCKmQKEE36MIsSCg1JE7JqgY?=
 =?us-ascii?Q?u8OBSq/2ntZhF9hPvf5DrLQK+Iw2xP8e4gCsr8DHR0cbteh+OWwIEnV/Ggyw?=
 =?us-ascii?Q?iq268u2JvgPGm+Ua6SXAAqWnxJA74cScaZN7MbRxuLY+rscmhK7NI7DH4z9J?=
 =?us-ascii?Q?jBiOKesZCLkAsKMK4HTHXp9njJoOpI2oyNZZ/TaVHrRjqNM5Cq0NCF6FHvpn?=
 =?us-ascii?Q?0gY21jHGDZMVxsvIm7YrUfk75FtVc1ThUzizyeL3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9d8462-2edc-4141-1296-08db1e7134eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 18:32:57.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seaSHFTFJnMUNywJC+cX4+agbzrmRccMy+rLxehS2BBbjWnzRBYChmO31aK7r/yO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=_MailMate_8B7FE638-8DB7-41C6-B77A-F74B08567DBF_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 6 Mar 2023, at 13:31, Zach O'Keefe wrote:

> On Mar 06 11:09, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Fixed two inputs to check_anon_huge() and one if condition, so the tes=
ts
>> work as expected.
>>
>> Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Cc: Zach O'Keefe <zokeefe@google.com>
>> ---
>>  tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index 76e1c36dd9e5..b8558c7f1a39 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -106,7 +106,7 @@ void split_pmd_thp(void)
>>  	for (i =3D 0; i < len; i++)
>>  		one_page[i] =3D (char)i;
>>
>> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
>> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>>  		printf("No THP is allocated\n");
>>  		exit(EXIT_FAILURE);
>>  	}
>> @@ -122,7 +122,7 @@ void split_pmd_thp(void)
>>  		}
>>
>>
>> -	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
>> +	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
>>  		printf("Still AnonHugePages not split\n");
>>  		exit(EXIT_FAILURE);
>>  	}
>> @@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
>>  	for (i =3D 0; i < len; i++)
>>  		one_page[i] =3D (char)i;
>>
>> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
>> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>>  		printf("No THP is allocated\n");
>>  		exit(EXIT_FAILURE);
>>  	}
>> -- =

>> 2.39.2
>>
>
> Thanks Zi -- I had this in my TODO-log, but was slow to get it it -- ap=
ologies
> for the clearly buggy code, and thanks for the cleanup. I've ran these =
tests to
> confirm (as I should have previously), and it all looks good. Can have =
either my
>
> Reviewed-by: Zach O'Keefe <zokeefe@google.com>
> Tested-by: Zach O'Keefe <zokeefe@google.com>
>

Thanks.


--
Best Regards,
Yan, Zi

--=_MailMate_8B7FE638-8DB7-41C6-B77A-F74B08567DBF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQGMdYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUjckP/R/VbuXFrmc6kTR5LqkpnGtxIDt8wFCxEWvZ
Zw8jv4Q57+PBu2iqhaQ7BEJEYi32EWUTQaqPGtAifZFEMwehy6hhVp+9K0opVnlO
DTl2qbxJb744Ma9SVpwfCCJHYsV8tkctmd7uo6qGnxmbLJGt/1Apqv9UQO5xd+Tb
njaExopx6WrBfHEw+nop47/meSK7Hny78k43FqCgk5PsTAx9OWFKAMpZaqaxZLQp
22zkuI1RqVu4c6ssOpWcuuzKJHzOJRFlE32NXz4D8I5UIhCLGFKbN7+465/0qwXc
W3sWs8tj2x1gsxdSjm6mryHTC+zJui6Hgqvh9VMJZJNXd7zNC7p2hMwIZTXBmrTL
BmdFG+qgPnN1ppeFbJ7RWDZPt0hEJTeVMQ1uWp3hOd8Gq37GjR0X344VerycDVke
fiJRUVp5WuoGvreBhAQVqqTyuWWObP/Qzb4g1jZG2OqKfvWIGSPBf2kNDUien77n
Lnza4Cwxy/fCMdeus9JYcu2vOGbhMmesbKkT6/JFpmKVButUEjFmM8sFZhun5+tq
7ZkoexF0g6kA02OfU56XXbmIEdpyEaZeY4FTGcHcG5WTvygPvhbONWvfTS/2GSwv
o9EyKQi/w6ggHuFOCBgmdqeI481aAdAEFouaSKUlo/ku04ijVIo8AdHPZYJjuOS+
4PxhaaYE
=koOI
-----END PGP SIGNATURE-----

--=_MailMate_8B7FE638-8DB7-41C6-B77A-F74B08567DBF_=--
