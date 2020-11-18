Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131EB2B7C42
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 12:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKRLSP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 06:18:15 -0500
Received: from mail-dm6nam10on2109.outbound.protection.outlook.com ([40.107.93.109]:63328
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbgKRLSO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 06:18:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bh75fIs2NhiA7kyroxlp75jU5mWQ2sTMLlFGBRom+Ci1ugk1DHGRQsp+y5rHF6sEHKdWQhNfitSK0sday7JRPbrMEuFGBPC6GOxhZ7iPj1cTnshvqxccBhGVrpmB0yL4o2mAVUWtZc8wuTPWQC1C3jeEHoDT9KmtPpVyPXYI+289oGxaXYRF14YXIgf/lPx4Ez8jxIMMOzJYiCNCZkbWxBgDRNeCXK0mbu/kExt49KwLaym29Ep9OOuepBja3PyYq10pn9qlSO+ItTWycJqy9XjycHa0MRJs28ojaCYZZn29J94AZ0MZO4iMjnQ+Glhl8xj45RMqT0YsVKNTR4V5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeomleSLBdlcKuIHyuV5kuvxZevX2SEeu0cSOHI6BeI=;
 b=NUk2NEox5TI0Zx27FFIC5h+BEf33Ri5bWBQPHnTVnFvY3e7qlc7m7YVd6B64s9qud/+QTWSeVbFzoSLwLsAVBSaTMVYWWj+L3cvx/wJqjvFkswvejbx+AAIb49YGWNiX0vKq6fwl5cTEp7yBf0hNZ2UVs1HnqRykoCPK3APHeFC5+CMoC5gQUknIeUDptcBvHgZ94p+jv7VTJzoTJykf0nsX8qzwGzVQTFFUZK/aehnvZOeDQ/qv3C+mZ/0yXaKUpMiXSH7XbKSPAVT+Zmoh2UTAwFgvVh+HxcA74O5zfis3nJ02qsrJgx5GaKdVa3DWbmiGxobwXipVgGCb3ofUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeomleSLBdlcKuIHyuV5kuvxZevX2SEeu0cSOHI6BeI=;
 b=UTI9r0z5yggoLezpMzVYBXecxlDegkVpYnRST5CH6jzYTkLm0qboexam6YV+oYCEPC605xvkiNTErFb3HnlHVp+bcjZnRyW8ftbv5GAGXMm0MP6M88iMWV/3p+79ME21t9+81le07WObYFU64jjVRlBjRe8EN+pPe0B1upFEfFg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fortanix.com;
Received: from BY5PR11MB4260.namprd11.prod.outlook.com (2603:10b6:a03:1ba::30)
 by BYAPR11MB2901.namprd11.prod.outlook.com (2603:10b6:a03:91::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 18 Nov
 2020 11:18:11 +0000
Received: from BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::84e0:4df6:7a70:eee5]) by BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::84e0:4df6:7a70:eee5%6]) with mapi id 15.20.3564.025; Wed, 18 Nov 2020
 11:18:11 +0000
Subject: Re: [PATCH] selftests/x86: Fix malformed src_offset initialization
To:     Borislav Petkov <bp@alien8.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
From:   Jethro Beekman <jethro@fortanix.com>
Message-ID: <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
Date:   Wed, 18 Nov 2020 12:18:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201118111123.GA7472@zn.tnic>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030504090102090502070608"
X-Originating-IP: [213.127.125.17]
X-ClientProxiedBy: AM0PR02CA0015.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::28) To BY5PR11MB4260.namprd11.prod.outlook.com
 (2603:10b6:a03:1ba::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.4.219] (213.127.125.17) by AM0PR02CA0015.eurprd02.prod.outlook.com (2603:10a6:208:3e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 11:18:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd4e250a-6e96-4cd9-0749-08d88bb3a1f5
X-MS-TrafficTypeDiagnostic: BYAPR11MB2901:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2901B4CAC0ABC03852E52BB8AAE10@BYAPR11MB2901.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGKuD1rcGo2fG6LQ2qVlq+n6dXJdrkADETdZ6hNDYhlzyZNr1Y5Ns4cvv0vXy72JtFZW7i83e/vU6wuz8cajQ1ihwUSONQMF+5FW/tWNBw5bIaJpeyxOelbGSh8GQVKg7Tsl0XlWNDWxwj/Bs3bVc+zf8tlp4zrgEBZwrnrflxXgchKa54SncyeMNBIMRy8XgS04jCAAnxo4vM23pgZ2R2a/JQ9JEs0AJdPYrmz8wYEZjaXknyf6uKSDdb7Tc+abKM7j8avi+qJYIsCcxdY5mLBrR9/oWQN0TnyM3SHqTaHeg24bBhnMQBPAPCMwvmB5agDi5dzD4r2Ur4R2Uk6c07edamcVJ6c1zWpubJw9KrwGsxyF33V3wWOo7hcerY7B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(136003)(366004)(346002)(376002)(316002)(478600001)(53546011)(2616005)(110136005)(36756003)(31696002)(83380400001)(235185007)(5660300002)(52116002)(2906002)(7416002)(4001150100001)(66556008)(66476007)(66946007)(4326008)(186003)(6666004)(6486002)(8676002)(86362001)(16526019)(16576012)(26005)(956004)(31686004)(8936002)(33964004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: m/ZPSF/mcZs36+1eHKaxyS9/m+jjiM6M61+pOytnMfc3o/nkHwwiZEsGgytL8hgvL5SzQ0QjdB6BMZn2JSRMjuRiMhG4wQj+SXs3FKN/0Vww9eBbbLARq5RkrtOi1H+K4flhZc50H5P/DCbu36NykooABUQGG4iT3e2UGL2aEHZFDl5RzZZKxPCvVaDh+f0XNivHHdDSur6q8gNx67docHic3Oc5h8y1wRhjZGmSe2o1VUcd0ON7ITtsfexkx2OmEakHnTbGMuxVzN/rMjw8NyeptAOtBkl2MvEX7KRonXiH8dFT6Ie1wMTu/jPNnylQRL3rGnzLd4k82JyBZ1pQFyGjpvLxdmG8oC7S7T0eMaCLrEVABxowp8adVASM10xjYR1eUPakZONfYhVhWKf/Xb2QC0o6s9d13Uuu5RlRS0SsLVqNARG28waofPA8EzxqHaxwqhBLea29x5g8mRvmf+hIm1og9PK3lelQ6YuB1BHGtaX4lpq+dr4aDph4k4VyTh1sTs8u9N9+B/cZrnUO+ASpp1+JaKiu++GTUPf2+aS6yIps0tldVaBSC0Qpcyicof1butNHBRx4vvU3iMlbljs3zhBpuyR4daPRg9D9BF1LCQzqo2DieXivzsDLsqTRHxACoRS1vBzc0inrB4vjvg==
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4e250a-6e96-4cd9-0749-08d88bb3a1f5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 11:18:10.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ot7SJgCpGlH1TVG6YeDI5epRQJkLx56JFbjbeVJRHrik9hD5hDyyLjwIPPpmzGRHmwuHvhR5SW1L/bndkj/kjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2901
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--------------ms030504090102090502070608
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-11-18 12:11, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 12:36:30AM +0200, Jarkko Sakkinen wrote:
>> Assign src_offset just to the p_offset, when first initialized.
>> This has been probably copy-pasting accident (at least looks like
>> it).
>>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>>  tools/testing/selftests/sgx/load.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selfte=
sts/sgx/load.c
>> index 07988de6b767..64976f266bae 100644
>> --- a/tools/testing/selftests/sgx/load.c
>> +++ b/tools/testing/selftests/sgx/load.c
>> @@ -185,7 +185,7 @@ bool encl_load(const char *path, struct encl *encl=
)
>>  		}
>> =20
>>  		if (j =3D=3D 0) {
>> -			src_offset =3D (phdr->p_offset & PAGE_MASK) - src_offset;
>> +			src_offset =3D (phdr->p_offset & PAGE_MASK);
>> =20
>>  			seg->prot =3D PROT_READ | PROT_WRITE;
>>  			seg->flags =3D SGX_PAGE_TYPE_TCS << 8;
>> --=20
>=20
> Still no joy:
>=20
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> encl_load: encl->nr_segments: 3
> encl_load: seg2 offset: 0x3000, seg2 size: 12288
> encl_load: encl_size: 32768, src_size: 24576
> encl_map_area: encl_size: 32768
> encl_map_area: area: 0x0x7f7ec8dd8000
> encl_map_area: encl_base: 0x7f7ec8dd8000
> mapping segment 0, seg->prot: (read write )
> base: 0x7f7ec8dd8000, offset 0x0, size: 8192
> mapping segment 1, seg->prot: (read  exec)
> base: 0x7f7ec8dd8000, offset 0x2000, size: 4096
> mmap() failed, errno=3D1.
> mmap: Operation not permitted
>=20
> That second segment is PROT_EXEC and mmap(2) manpage says:
>=20
>        EPERM  The prot argument asks for PROT_EXEC but the mapped  area=
  belongs  to  a
>               file on a filesystem that was mounted no-exec.
>=20
>        EPERM  The operation was prevented by a file seal; see fcntl(2).=

>=20
> I don't see fcntl() calls in the test and the fs I'm running it from is=

> not mapped "no-exec":
>=20
> /dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=3Dremount-ro)
>=20
> so something else is missing.

Just to double check, since you didn't show the /dev mount line: that is =
also not mounted noexec?

--
Jethro Beekman | Fortanix




--------------ms030504090102090502070608
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DVUwggXgMIIDyKADAgECAhBukmvE8GLB9+EYd88699DiMA0GCSqGSIb3DQEBCwUAMIGBMQsw
CQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRy
bzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1
dGhlbnRpY2F0aW9uIENBIEczMB4XDTIwMDkxNjE2MDk1NloXDTIxMDkxNjE2MDk1NlowHjEc
MBoGA1UEAwwTamV0aHJvQGZvcnRhbml4LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAOM9pWqcukwLqKxwz61HtRU+YK4w6EwrvjLtFeWi0T2qXSpA9ePS2c2PB2rCoqR6
VZehtzjp1FvE1X1Mry5j9Qb529a+wuhxrCH/ecULCOX3x1eGaYFIUbehmpztnvNkGowLCDWq
hsIU70LAa6KgAcQ7bcc9yR8jhLgF9S9+M74olvpKRYI7EH+biSPa4EhUJ5lvOo5uotEi7K19
zBqlZaz/d9U0YOL/19UxKx+0a7UHu1JC8cHZ5WiX680KyZhoHsHxitzRoumttYO+kZCKykVq
7mfpzWxedVTEARnMMtMFKDCjWoBZwNNLY/EyimgQpl82c9aaebavpxBngrm+88UCAwEAAaOC
AbQwggGwMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAUvpepqoS/gL8QU30JMvnhLjIbz3cw
fgYIKwYBBQUHAQEEcjBwMDsGCCsGAQUFBzAChi9odHRwOi8vY2FjZXJ0LmFjdGFsaXMuaXQv
Y2VydHMvYWN0YWxpcy1hdXRjbGlnMzAxBggrBgEFBQcwAYYlaHR0cDovL29jc3AwOS5hY3Rh
bGlzLml0L1ZBL0FVVEhDTC1HMzAeBgNVHREEFzAVgRNqZXRocm9AZm9ydGFuaXguY29tMEcG
A1UdIARAMD4wPAYGK4EfARgBMDIwMAYIKwYBBQUHAgEWJGh0dHBzOi8vd3d3LmFjdGFsaXMu
aXQvYXJlYS1kb3dubG9hZDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwSAYDVR0f
BEEwPzA9oDugOYY3aHR0cDovL2NybDA5LmFjdGFsaXMuaXQvUmVwb3NpdG9yeS9BVVRIQ0wt
RzMvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUqK9FZHUTZ7vhJZAsuniSiMn24q4wDgYDVR0PAQH/
BAQDAgWgMA0GCSqGSIb3DQEBCwUAA4ICAQDscghwA0YyWZ/w0dFhxfLbqpiHNx1UDWFp1GUi
BjZvpNEkKWtOPbBAkdShWBpLFsDH05PiladSagxxLPmdzRRytHwQ+LWxZhdMT1cz2ypVtKkq
3FiuDu41W4HoGhGn0fQc4FJzLEE0WJGTgP2zr7JcRISDgmFBHdinoVe3ZR+pbURoiuDcHK2D
BgcC4dguyxdVR5gLEyiqsCTNj+tfbopC0yAkInNMaAHS/IVH3GRyQ5xbXgczWu+agxxnOjU2
KuaQL+RNX7l3aPdp88DSxq7PFC3KOk5G4qz2Ts7nh/piR41vIh0q/Dfc1yCClWaTQqBgQvzT
uW8BQwq8mx5E7owmzj9IzZHRX69wkLGG2Yr7WinWp09yzmMNZRH2OrEI9BmKtafFpdr3me/k
lyv4RUlg8A+cNHAlL6cY6mHYrTu8xbzBlhOTicGB7JVhx+zLdL9TKI0P5ssPWfZOE4W76lSC
+pFr7Kb7z9037m31TKh2F3cZAh8Mg/XyPm6NTu97ItoOrl2BNn26P6jZlGuYCYUHqsxAc/pJ
Z8PiuTlLt1YX/pAXeCBHOmzbUTxdbG4tPvFmlI50c7GMW67Jto7Vf4XFa5NItqcQ4sXFT+tZ
3u6BEJ8P1hmvCwn5KSErm2kWLV5P5bkzBHajRsx0rE1VBALmHL25nbHGcOCQhaCgVgooHjCC
B20wggVVoAMCAQICEBcQPt49ihy1ygZRk+fKQ2swDQYJKoZIhvcNAQELBQAwazELMAkGA1UE
BhMCSVQxDjAMBgNVBAcMBU1pbGFuMSMwIQYDVQQKDBpBY3RhbGlzIFMucC5BLi8wMzM1ODUy
MDk2NzEnMCUGA1UEAwweQWN0YWxpcyBBdXRoZW50aWNhdGlvbiBSb290IENBMB4XDTIwMDcw
NjA4NDU0N1oXDTMwMDkyMjExMjIwMlowgYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJn
YW1vMRkwFwYDVQQHDBBQb250ZSBTYW4gUGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5B
LjEsMCoGA1UEAwwjQWN0YWxpcyBDbGllbnQgQXV0aGVudGljYXRpb24gQ0EgRzMwggIiMA0G
CSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDt5oeWocGktu3CQlX3Pw8PImBfE+CmQ4iGSZF5
HBsvGlAP3EYB7va6OobMUWHvxA+ACHEpWq0YfNh6rRUlULOGcIpEFtVf4nAiEvdQtiFQBmtW
JSn3naoMHqpMvmwZ4lL0Xr1U9JHmTqkU3DuYcNNO3S+hYWDZpWQbeSGibNVeiJ4kY6JDh0fv
qloK1BsuS3n2OgArPYGfAYtDjCvT2d+6Ym3kArHZjEcrZeBI+yVVnjPwbTSCKax8DtS2NP/C
J6RjpnRvuSwusRy84OdwdB71VKs1EDXj1ITcCWRZpkz+OhV6L8Zh+P0rmOSJF6KdHiaozfnc
URx4s54GFJNRGkx1DnCxcuL0NJMYG42/hrDYOjNv+oGWSEZO/CT3aaLSMB5wTbZKfcD1R+tT
anXD+5Gz5Mi15DTE7QH8naZjZxqqhyxL1KyuIgaVDxvQtPSjo5vTsoa09rn+Ui8ybHnvYO/a
/68OIQIHLGbUd2COnwm0TiZ3Jg/oYGxwnJPvU1nDXNcecWTIJvFF5qD2ppJH3HgJVVePUEOY
1E4Kp3k0B8hdRdhMV5n+O6RCKCTFcZaESF8sELgdrqnCLPP1+rX7DA8pxZoX0/9Jk64EOsbf
QyLIJlrrob2YS0Xlku6HisZ8qrHLhnkzF5y7O34xmatIp8oZ5c54QP+K5flnTYzWjuIxLwID
AQABo4IB9DCCAfAwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRS2Ig6yJ94Zu2J83s4
cJTJAgI20DBBBggrBgEFBQcBAQQ1MDMwMQYIKwYBBQUHMAGGJWh0dHA6Ly9vY3NwMDUuYWN0
YWxpcy5pdC9WQS9BVVRILVJPT1QwRQYDVR0gBD4wPDA6BgRVHSAAMDIwMAYIKwYBBQUHAgEW
JGh0dHBzOi8vd3d3LmFjdGFsaXMuaXQvYXJlYS1kb3dubG9hZDAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwgeMGA1UdHwSB2zCB2DCBlqCBk6CBkIaBjWxkYXA6Ly9sZGFwMDUu
YWN0YWxpcy5pdC9jbiUzZEFjdGFsaXMlMjBBdXRoZW50aWNhdGlvbiUyMFJvb3QlMjBDQSxv
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBu
kmvE8GLB9+EYd88699DiMA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMTgxMTE4MDBaMC8GCSqGSIb3DQEJBDEiBCBe
KYZZ5DlNI1Z6sT5DuuZS+TXGVM4TPSt8v0G0CXTTrzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG6Sa8TwYsH34Rh3zzr30OIwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBukmvE8GLB9+EYd88699DiMA0G
CSqGSIb3DQEBAQUABIIBAGOglm3onl2ctpOdnRm0yNnejINloIMQKG3+IXoA/W0LQasRor1D
ibtVKK6r+xubWJfAjRFJKBP+EU06SX97OlVtZq7gIJbvNaALd+fRJgAiQUMi0PTliYW83a7h
qAM2dw4U3o1otZc8Xd3FNPf1r9/jQD9mVJqnSk7WD2YzY6I7QwW9dJQInW/xGGQeWjmYlBbx
pYG1TvO4rv1niH6jpAunxT4ws3Wau9iL/QIjMSZD55bSYSsTmqrJ27dDa1B6p1O/KVxKM4pa
rRyzgZo17jU65iCWaXsYFgkfe7Xf6QEBzHiiYxwVCvoDSIGSOdjzz21K/CDuVGDtl/DkPsZ1
QrUAAAAAAAA=

--------------ms030504090102090502070608--
