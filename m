Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2C6329A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 17:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKUQfO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 11:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKUQfF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 11:35:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A64C8CA9;
        Mon, 21 Nov 2022 08:34:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALFNHTB023984;
        Mon, 21 Nov 2022 16:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4iCV1LMD36IET7kMESnHr6QZx6qFYqsh4eT+7aVrCPw=;
 b=QwEpTeeGSXT0bMbJ8CDyoEfiKkCVnBvo75phN6KOSSrDdOT4wQwhBTM13feI02sLqq+O
 FqaIdDz9HDOh7G5UWaKcFtTYwiV51l3TCSMktKuGA1q8/PSs36pMmQE3f4IEh/BzoP7q
 uqnLEc/N9YD86JLVIln7a6haJkZpl9glhz/PHubU2b+uFvfYVEK4CAqsiUlGW+PYTYIK
 iassyiMYG9LmvtDeF5UqFe3MKzayab5uvqq0uGRzXIr9SqeunqZGv0u1U0DAkY7x66da
 oW9UslL/tAZPC+RC8eegnv9ujBZe3PMCGoHcjXhXa/AtVSlknzmu0m3H/FwUV+h3c/JN Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0afr0mfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:34:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALFQ8Mj039508;
        Mon, 21 Nov 2022 16:34:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnka8gjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NibyhKnGvctZdK4yJf5sEADmZoOn4kocuJ8g+e8BBigVV+A3LV/jTW00LbM+gl7/rsj+4uEHUqJmxri/qK05mCYSUKEEIYgJYLcbrrhwWU0qUPqFEkWuFHvtokjQW2VYothZ5DqCCmudpQGAdRQBQq6lIAHT7en1i5mMJTqxqhyu2Wh7+/lVpu/7JXvL52xtdDWz1fRJ+Us/66TvqNlZPK2xY4OJZ2CArU2h7rjJFmn5hqEHxZo12/WfVT5o5KnkxUstqp0n3mI3wVar7pBezqDvPKjgBIrktP0ibVJxnqME0JxonntYWHKEyqjuI8ngquqIGWITg9SNyFDFqYCOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iCV1LMD36IET7kMESnHr6QZx6qFYqsh4eT+7aVrCPw=;
 b=bEq8BR3jRJ9OgfsZAvhQ6zSTLsxzdUf2bkt61/yadn477DY11DpSK86HGnkxNni+gCqeDg+L3pCfIXwTN+xCWpaH4YceaHoa+5sq09Sf+VP7xupFNIjEbbf+JmE1zSJYqt9xWGzM3FE0HJaJDFxs+ZemCp9KEm/cIYbDG9EulKZ07tdnbwPC9zcykhLX3LCfMy3HNdAVadSkbuUgtIXGK/SeKILv+Cs4KFXA8kUl5OtWRHGdEcSizbMDFxMoigP4MZ1MzfCeUbMZjkiYPxOHYqDuRdeZ+UgkIB9kyNKTbzOiktMr543E34O9BvBxHREl7ei/qIyfrL7KTcytrkMnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iCV1LMD36IET7kMESnHr6QZx6qFYqsh4eT+7aVrCPw=;
 b=WKxHQIWKBG1mi7sNlq9/v60ubE3rKd530LOMspurgVfLbznHMgO4C4dGk7OJrhWbl48JPRLiKiz+GKbZe+aj++1fRw3CFWNfFCkgdS/yr3kMDRB9YVup3zYvRgVddbcKvqonfikutTGvtGXfUd9q5vLmW0wzpmQMXizC01h1jj4=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:34:31 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c13d:dad:6a35:b25a]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c13d:dad:6a35:b25a%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 16:34:31 +0000
Message-ID: <a1fc425b-4c59-090b-f475-caf7d6074042@oracle.com>
Date:   Mon, 21 Nov 2022 16:34:22 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 8/9] KVM: selftests: add svm part to triple_fault_test
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Colton Lewis <coltonlewis@google.com>,
        Borislav Petkov <bp@alien8.de>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>,
        Liam Merwick <liam.merwick@oracle.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
 <20221103141351.50662-9-mlevitsk@redhat.com>
From:   Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20221103141351.50662-9-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0292.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::9) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b48f5e9-4ebe-4e2d-0d30-08dacbde4428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sisq7+xrUor4W/q7vhEU4B/hT7vKca8PbFMrf5bANum9vVyTsECagISdN7jXivCdAeGuU2wAJ1P/4yvGUliqimOzgHmbIWJKAWeGWoemmJf2gJLrpAjfPU2m25xd9W0yR8Xek+xudRBWjUIkjt1lESk8JvMS/ZknboUg+mOtydXbFo8MmEJisAXOs+/LF4Mrv9r6TjPTll/WRgrejOeMtySBRZ4gjNuI+rIdAhzWI7t1hrCfcan/nT/OCJXTtw8JF3bYnIQa2xCNVXS9sNjl5jypeeP0+IjWnLTtk0h253z/kiImHEsPoalbyT8fuqH00ryBDAW2H955D/BSVOpzldztOdcbJTsBVxONQClpITpvts4cnRiX0lsUb96Mi2HfQHfUd8oGB/VoiKlPl73GMOVuLoiLDgHIy+ddq38eF7vtCH9iYM+rRTJVghf2pSeOlfjESmES90g2PhljaSNYjRjtIy9S8r4W9mhTtSC/rGw8zBnQTXTGj7w9rxI4X6FjSxyHfsVQjRpyKngRZEHbnZUMFCfxbg0AqkEUo6q9i6aU8TcxFee1cUdFRm/c2WLopTqNehO1oA5fK8bHwsSPxyWblVN1Deq10vzDXhliDB+2Huu6XgBx/sdzT7O8DsiDiWPiPbqsaVUhzHoAKAVaMTZLnYY6Ufu2ulv/VOepAO55CwmatWw9XJCVEfSJEsa/IS3ma9DwE9DQjigu07IrFhxjgkQkB2t3hW8nlLI6Uo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(2906002)(31686004)(6506007)(2616005)(66946007)(66556008)(41300700001)(36756003)(31696002)(86362001)(54906003)(38100700002)(83380400001)(53546011)(4326008)(186003)(8936002)(7416002)(44832011)(66476007)(8676002)(5660300002)(107886003)(26005)(6512007)(478600001)(316002)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHlnTVZSdTVSbHlZNGc4akEwM0pMZWxtait4emdWb3I5WDFKSWNEQmtIRGlR?=
 =?utf-8?B?TkJtMjdxZGljOVhsQWdLQ3dqclJZLzZkY1NPWUxIdWczK2xhYlJaV0djR242?=
 =?utf-8?B?OVZBSHlYT2lNVGJTVFZNczZVNXZ5OHE3czVZQk9KUVJjUkp2NG83WEdQVW9X?=
 =?utf-8?B?ck5JbzZKK1hKNW1CazZ2Y3ZRVWtRZjNnTXAydmwwNUtHd2FnNW14Z2oyTDFM?=
 =?utf-8?B?c3ErWEIrT0syTklVYjl1dHAvOGJISDJFenpEV1U5dmt2d2pHaHNzRlBLdnVC?=
 =?utf-8?B?UmxES25mK0RxK01SWlM5bVhldzZrMlR2OWQyanFuY1ZSSXIvVEN6aEdLR042?=
 =?utf-8?B?YUNHTStqblI2cFhhcXg1OWQrQ1pMaXgzYkdlVThsUmliQ3NUamNDVG9JL2Ey?=
 =?utf-8?B?NW1UUjFOb0xJV1hKc01UdUk0MUt5WGw2aXgrRGhENFk5WnEyY09CNjRzRXpp?=
 =?utf-8?B?QlJKd0ZtOXh1TXBIR2JVajlUblRvU2hGQU1NQ2U5L0tVL0JORlFhcnhZWWZ2?=
 =?utf-8?B?WHpYQjJ0T2xRV2hraUZiaXlPMzMzN2NqVmQrTmsrYWRMRjh5eEpvY0h6cU9G?=
 =?utf-8?B?RkQwc2l3UGdrQWFsYVB5S1hLc2RBS1lFQWJ5SXN6LzRweGN5Qzc4bldPT0gw?=
 =?utf-8?B?MWc1cWdqSU92SzRFRi9SZllyTUc1U0ZrZXNTQ2JGdG1uQzcvd2FWN2U0Uld1?=
 =?utf-8?B?NXpIZC9GYUsrNjIvOGtVNGdXTm5Lc2tuZVY5S1RCK2lmQ1NJUTgwckhkY3hW?=
 =?utf-8?B?M2JZalREZlRYUnNqeXBCWTk3RDhCS1g5aWJ1K3Y0WWtkb0FmU0g5VWJLSnJ6?=
 =?utf-8?B?K3dicUwvQm96V2t2aGRDRXVOVUJ0ZHBLUjdUZjR1UkFEWUVKODZuZjZoelEr?=
 =?utf-8?B?S1MvYWlldndhVkw0T1E0SmdvUGg1VlpFQjRYVlNTVk0rOWozd2xmTU11dHU3?=
 =?utf-8?B?eUMrMmJod3hDaDRZTDlVQnBjVEtwU0F5UmxVdDYwTU5QK0wrbFhBOURiMXpk?=
 =?utf-8?B?bU5FdlJvVUhycUtxVzN1ME5mdStkMi9zUi9OLzNaUWxHbUVqZXoyR0c5bmFo?=
 =?utf-8?B?cFNBQXFkNUxvdmV0a04rRTUxd2ZQRjNyMzZ6cTBROFE2VkZSdEJsWUw0Y3d0?=
 =?utf-8?B?OVZTS1g0aTlxZDNkK0o4Uk9VLzJNek85UVpYQ2hvN2JUQWN6YkExelJkMjdj?=
 =?utf-8?B?aG1wV25zSGwzbTVmZkdkaGsyWm9aOWFqbUxGa0JYeWkwS3Z6azhaa0JaU0Nt?=
 =?utf-8?B?WHJ3RFozM2cwQmEyWENKalZ6ZDVVS2pxdEpybkN3dE9DQVozWTVNbSs1N3Bh?=
 =?utf-8?B?K3RjU2hpaVRwcjVnbGZsekVnK1o1WU1ZQURnMmZVVjVBMWp6a0hMQjl5ZG1C?=
 =?utf-8?B?NmZiempiUm5wemJCN0xTU0d6bzU3ZHN4TDdRaG9Kbm9VNkhBYXkzeENGVVF4?=
 =?utf-8?B?L0FDRmliT0cwd0pOdWVaMlM4TElURnBzckNpdmVTOUxTSEVYb0oyYUppVnNt?=
 =?utf-8?B?aG8wTDZiUkxHTlIxQ2Z5WCtyQytPTDUvT1lPTEgvTjVEeCsrWjdDQkJTSEFh?=
 =?utf-8?B?V1RhaDdyaVMvSmcyOGloY0RXeEc2alZxNGtHTkxFZ3RkNzYwdktMd3NCMVlv?=
 =?utf-8?B?TFMvRVlsTlpBRThROGtPT2cvVE0rRnBkVmQ3anZVb3pFdzB1d0hoM2hXMW5C?=
 =?utf-8?B?bmU2R05nSGJWbFpoY3lFWW5MdVQrc0kzM2w0eFhlSjBtM0VDUEpWTDBUcm5t?=
 =?utf-8?B?TVZTbjQwUW5ReXNlUGorWm0wM2RCVHljNzlnRFIzenNCRFZhSjFxbjZWYjdR?=
 =?utf-8?B?N1lvUGhqak1QSEFoRUtnYm4rZ0VOWVdPUnlWQzNubTVZYytmaGNVY3dzVXlE?=
 =?utf-8?B?azRiNG5YZkZoaVV4SlJYUDBJaFZzNyszN2tGbjFRbS90ZFM4WktIVE91TEZr?=
 =?utf-8?B?SU1hTVJpZ0hEN2lzQ2RxejhlNmM5OFQ5dyticTJzc2R0Z24ydDdiZG16Y3c3?=
 =?utf-8?B?TFNUMVZpUm5XWEZkZUp4WHJKZ1BWV0U5RDk0aHhBcC9kVVdrb2M1MHlwQkJa?=
 =?utf-8?B?cnowUjBqVGwxdHlUeC9wTWFDS1pnOEx1ek4yS25ML1RqQXFyQ0l6dVBkbjhQ?=
 =?utf-8?Q?/ywz+lUMnNtCnefqv5ECV73Qu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cE1adkViZW5HdWRjZzR2b1JPWkQ2QzFEOTkxZ2duYUlhcWNZRTRmcE5UN1g1?=
 =?utf-8?B?RjBYRmxDdnZUdkNqZ0E5RWxlWU15RlcxSW1RSjhuNFFjTE5ScEN1UVpvYzdD?=
 =?utf-8?B?NEhTK1J3NXlVMlg3L3BFbnpGTHZOSVhYaTJucWVpaWtPdDU2VmhSaldUM1JW?=
 =?utf-8?B?Z2Q4aFlRUWM0SVoybFB3TWx4Nlh6angxUnhGMzVlY3lxbmxyZno0aWdjY1Ni?=
 =?utf-8?B?a25XYitVaE5jVXhuNys5TXppa0N1ZjJTdmN1VGo0Vmc3T1hzYy96NUVxc2Ru?=
 =?utf-8?B?bFA5azc5L3ozdFNNaFVOK20veGRtMkNLQ3h0T3M0c3dTczFMVUlyc0thcFIv?=
 =?utf-8?B?Z25KUUhicWxMWDkrb0ROVjkwbm9JQjZseUJ1RHpZVWZCT1V0dGVXb2JVdnNH?=
 =?utf-8?B?VU9NWmp1dzgvaDY2WDkwMkVxREtZbzRvTFVlbHdQYU1CYXQ2ejNTQnBpWk5K?=
 =?utf-8?B?ZVpNYkhOMGVQUjdZK2Jiem5COS9yTFVhVmtZR3Q5cnkyVzRubVdYNm9zOVRw?=
 =?utf-8?B?Q3QzNzV4eFN0dkFNallUeFFEQVdHd2lqUDRYeVczRUQvVlNYL00rNEtHbHVY?=
 =?utf-8?B?QVhGeklzL0l6UE1rTjhUVGJONm5oSjcvOXpMYUhrZ05GU2RQalBXOVpjUjF6?=
 =?utf-8?B?STlxdFV2Y3NUUUNoTGoxZ0x5c3AyTXluOWw2VzRocmJSWGRqRGFiRUlkckRx?=
 =?utf-8?B?bDZtVmxtQXVuMHVXVitkaHlld01JallVNW51VTNndENFZDV4SmRVRjhJY0h2?=
 =?utf-8?B?bmF3YVBicnB2MGZnU2hvTFBSRjNwdWNzQnk1b2pNTFBxNnZwMnpmN0pFU0dB?=
 =?utf-8?B?Mmp6QUxsMHBuN2FwR21ETzJ0b1Z5c3I4OWhWTlMwNFJLZ0ZyNWI4a01nUHlG?=
 =?utf-8?B?VWpMdFhFZ1JjVEppbHRlSVdLdXlYZ0lSVDBiYlNEUmdFN3dsL3owZVRLYXhD?=
 =?utf-8?B?QS8yOHVVN1hFUDg2NXk4ejVodGF0elg4TDFEcDB5Sy9VOHI1Rm1UOFFKbFRC?=
 =?utf-8?B?YmxnQmVlMldQQURmVUptRE9qSk5ONDJGa3ZTYlFxQ0Y1QitwbkdxRTBWM2JL?=
 =?utf-8?B?Yk1mMXdrM0JRNnNNM1dWYXNXcE12VHpxVjVMMHdmMko3ejBTL2ZpWGlGVE9x?=
 =?utf-8?B?SHVmYlFDOXpRVFU3bCs1TUdScFRwYTRoRlZ5M2JGWWhKbUZocXB6Y1Y1MlNI?=
 =?utf-8?B?Q0pXQW1zL0FOa1ZlYmFPdDluNE9KcGtVUmlERU1RT1U5dXZmNjFGcUNqSHla?=
 =?utf-8?B?VWNqYWRJTDlZczlzQUZjNUpOUDNVSncwdDBnK3J0NEdDQUNvb2hmSGE2UWJK?=
 =?utf-8?B?N1lsR3dYMi9mQnNhc21TK3dxR2xZRmg0OXR6RkFOSjR5bmdINVBnNXVIekpk?=
 =?utf-8?B?WWxLK2FMN2JMQjQ3bGwwSEVqUjUrQTJBYk1wdUJ2NFd6ZGluczZtVmY3REZI?=
 =?utf-8?B?dGt2OFYvTnZZNjRsdzVrcUN0UkdydVZyYWsxYmt4WDhSekIrQTBKREVUQk04?=
 =?utf-8?B?aE9vRkM5V1RkWXhUbmsxSXRUdWRBZ3grMkZhTm9DbVhPU2xkQVEyUGR4SVlW?=
 =?utf-8?B?bUU5MDI2Uy9WMzZzNmRTM0p0K0RhbHJ5ZXlSdW1rbmZ3WU1aKzBhU2k3cmMv?=
 =?utf-8?B?OHVBYk9KdlNRYVR5MmhKdWNkcml2VXB3NGVEYUpZSHh3NmM0bnpFMllkUTMw?=
 =?utf-8?B?dnBrYVdkRjRYN0NzTkdVOS83YjJtdmVXVHNMYlFPZC9mUVdUbmE0NHg1SVRx?=
 =?utf-8?B?UE1VYitmTEVIci9may9UYzlKRUgyWWl5SE5TWnNUcVRxdW02ckt3cEpaYitO?=
 =?utf-8?Q?qwaVt2epTwDqO9KrUfQ9nrMuM9igqIBjjm7KY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b48f5e9-4ebe-4e2d-0d30-08dacbde4428
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:34:31.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl4xghJ83Uu19pHVlOIuBkBzap20psRJc5jN1BtWo38pQWzLYod5vA2nqm5dkEIsYpT7LC7o29cILwAcEsw/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210128
X-Proofpoint-GUID: IreWhFjUHWkniOUtjNhPRYlC8jLu3IYE
X-Proofpoint-ORIG-GUID: IreWhFjUHWkniOUtjNhPRYlC8jLu3IYE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/11/2022 14:13, Maxim Levitsky wrote:
> Add a SVM implementation to triple_fault_test to test that
> emulated/injected shutdown works.
> 
> Since instead of the VMX, the SVM allows the hypervisor to avoid

maybe "instead of the VMX, the SVM" -> ", unlike VMX, SVM" ?

> intercepting shutdown in guest, don't intercept shutdown to test that
> KVM suports this correctly.

typo: suports

> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   .../kvm/x86_64/triple_fault_event_test.c      | 73 ++++++++++++++-----
>   1 file changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
> index 70b44f0b52fef2..ead5d878a71c45 100644
> --- a/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
> @@ -3,6 +3,7 @@
>   #include "kvm_util.h"
>   #include "processor.h"
>   #include "vmx.h"
> +#include "svm_util.h"
>   
>   #include <string.h>
>   #include <sys/ioctl.h>
> @@ -20,10 +21,11 @@ static void l2_guest_code(void)
>   		     : : [port] "d" (ARBITRARY_IO_PORT) : "rax");
>   }
>   
> -void l1_guest_code(struct vmx_pages *vmx)
> -{
>   #define L2_GUEST_STACK_SIZE 64
> -	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +
> +void l1_guest_code_vmx(struct vmx_pages *vmx)
> +{
>   
>   	GUEST_ASSERT(vmx->vmcs_gpa);
>   	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
> @@ -38,24 +40,53 @@ void l1_guest_code(struct vmx_pages *vmx)
>   	GUEST_DONE();
>   }
>   
> +void l1_guest_code_svm(struct svm_test_data *svm)
> +{
> +	struct vmcb *vmcb = svm->vmcb;
> +
> +	generic_svm_setup(svm, l2_guest_code,
> +			&l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +
> +	/* don't intercept shutdown to test the case of SVM allowing to do so */
> +	vmcb->control.intercept &= ~(BIT(INTERCEPT_SHUTDOWN));
> +
> +	run_guest(vmcb, svm->vmcb_gpa);
> +
> +	/* should not reach here, L1 should crash  */
> +	GUEST_ASSERT(0);
> +}
> +
>   int main(void)
>   {
>   	struct kvm_vcpu *vcpu;
>   	struct kvm_run *run;
>   	struct kvm_vcpu_events events;
> -	vm_vaddr_t vmx_pages_gva;
>   	struct ucall uc;
>   
> -	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
> +	bool has_vmx = kvm_cpu_has(X86_FEATURE_VMX);
> +	bool has_svm = kvm_cpu_has(X86_FEATURE_SVM);
> +
> +	TEST_REQUIRE(has_vmx || has_svm);
>   
>   	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_TRIPLE_FAULT_EVENT));
>   
> -	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
> -	vm_enable_cap(vm, KVM_CAP_X86_TRIPLE_FAULT_EVENT, 1);
>   
> +	if (has_vmx) {
> +		vm_vaddr_t vmx_pages_gva;
> +
> +		vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code_vmx);
> +		vcpu_alloc_vmx(vm, &vmx_pages_gva);
> +		vcpu_args_set(vcpu, 1, vmx_pages_gva);
> +	} else {
> +		vm_vaddr_t svm_gva;
> +
> +		vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code_svm);
> +		vcpu_alloc_svm(vm, &svm_gva);
> +		vcpu_args_set(vcpu, 1, svm_gva);
> +	}
> +
> +	vm_enable_cap(vm, KVM_CAP_X86_TRIPLE_FAULT_EVENT, 1);
>   	run = vcpu->run;
> -	vcpu_alloc_vmx(vm, &vmx_pages_gva);
> -	vcpu_args_set(vcpu, 1, vmx_pages_gva);
>   	vcpu_run(vcpu);
>   
>   	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> @@ -78,13 +109,21 @@ int main(void)
>   		    "No triple fault pending");
>   	vcpu_run(vcpu);
>   
> -	switch (get_ucall(vcpu, &uc)) {
> -	case UCALL_DONE:
> -		break;
> -	case UCALL_ABORT:
> -		REPORT_GUEST_ASSERT(uc);
> -	default:
> -		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
> -	}
>   
> +	if (has_svm) {
> +		TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
> +			    "Got exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s)\n",
> +			    run->exit_reason,
> +			    exit_reason_str(run->exit_reason));
> +	} else {
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_DONE:
> +			break;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +		default:
> +			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
> +		}
> +	}
> +	return 0;
>   }

