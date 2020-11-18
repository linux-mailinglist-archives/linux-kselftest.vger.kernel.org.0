Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4EA2B7D2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 13:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKRMAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 07:00:46 -0500
Received: from mail-bn7nam10on2135.outbound.protection.outlook.com ([40.107.92.135]:54496
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbgKRMAp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 07:00:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0yy9Rsou/OlfT9M/bgkiDeXVcUYAy6KuGWjrXGxSnroAWfP/bUqoxsCjNHAVUia5Kbdp0xLlJDjEP9KfRO6L/uY2Dm4WFd8H9ZPFsjHi4lLDWD+ydJ+4nJA0awTvhSgqz4hDT5u3nEB8UXfgJSem5IGBqaK1i/rI0zQ7aS5hkWkWtj0HFmFLIzARIGleJc8LCzA1V9P1HFMtrO4gLinVYUQr3ZQSZgC8Av/v8zHSG6vYKS+gPYEYOPYQ3hPJ7B/n0bwre9wPRoNiYPGqZATkA+2dbUBzyaUs3I9hxBq89pjoKvqH8QH6hJW2jPNnJio20ERDqLmJwCjQ/FhNvIFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpP+p2aX7UZ+Rf/AazyfWVev8XOfUenbTVUpP0B8ZJQ=;
 b=bXQ7Kr9xcEBmYaMEZFDoKvLcioB23TBo0lasmnF2fAIi/n+pX3X8hsvhrtnCo0pe800fE25z3VjEnZvFJKSpRZzXXxmHOyhnVhzEHLfotE9veqS+oaHOrXH6OaK7dBzmoPJlNdnC4JdRUgXkK45n2OiXYtiD/sTuXrA3+cyIwnQwGpnVlCyhueOpQC2n5vg4KdfDyU2dCVaVPJFTFa6n20Uc83l52le7zI5KYdlFzYbM8TCnccpCqOkGXHyBbg3V+wqx7t3u05Jolk5NLoQUezN37OjsY8KeauUrvcSVvcHCNtdvt7NVr+wdZLqUoX3O8Y2ujf3cO3fcjC71nn12zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpP+p2aX7UZ+Rf/AazyfWVev8XOfUenbTVUpP0B8ZJQ=;
 b=vPR+yJORq/irKir3ahEiDk4K4XmCBaKadpNmgbGeRSVr/1Q2c0hOgvjMojdkEW3RIh6UWn7Z9YLT0Sh+C8Htb3hl4FAlxYQH7Rum0qnFNwJ9geHvKTUEiH5zGQZDPJT2ineFXVdegQySLvXAlmVyxL1h5inSWYi4KNhpnem6f6E=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fortanix.com;
Received: from BY5PR11MB4260.namprd11.prod.outlook.com (2603:10b6:a03:1ba::30)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 18 Nov
 2020 12:00:41 +0000
Received: from BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::84e0:4df6:7a70:eee5]) by BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::84e0:4df6:7a70:eee5%6]) with mapi id 15.20.3564.025; Wed, 18 Nov 2020
 12:00:41 +0000
Subject: Re: [PATCH] selftests/x86: Fix malformed src_offset initialization
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
References: <20201117223630.17355-1-jarkko@kernel.org>
 <20201118111123.GA7472@zn.tnic>
 <554ac441-6b48-1296-3149-e3e385b6110d@fortanix.com>
 <20201118114444.GC7472@zn.tnic>
From:   Jethro Beekman <jethro@fortanix.com>
Message-ID: <0d2b3af9-eb19-b5ad-aa82-f85ba2a3ee4b@fortanix.com>
Date:   Wed, 18 Nov 2020 13:00:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201118114444.GC7472@zn.tnic>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050004040700050900060404"
X-Originating-IP: [213.127.125.17]
X-ClientProxiedBy: AM9P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::27) To BY5PR11MB4260.namprd11.prod.outlook.com
 (2603:10b6:a03:1ba::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.4.219] (213.127.125.17) by AM9P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 12:00:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99966cd-a5ff-4c11-a704-08d88bb991f4
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4829:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4829B238CC44C55F95CE3116AAE10@SJ0PR11MB4829.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAyUnbeHXUKRsWogAltkkW+pnCnWAx7+IWSWlRrXSBor8Cm1Ly2Rtro4cFi8wfGdHLA9w0J8pNw1NeS+zCl/xmk9SJQHHAdFwXWDthhUJ3evoQlQ1FZxwF7JNhHvNm393s02dosgatDNC5jXg/VALHta6dL/ZbSngNz+VntibXkUAM7jFS8YeDfLeRGC8WTW/Xun4YjjouTwUnEofVKeEp5I827j5sMXi3xN+Iq8bG/W3e1VurxdyVMyUIOabp+nMqOJeNsJ1D2Q5349z599XSKh64G609Cv+28jWZf1Qt755aZp6l+vhOg3dz+14t0Mh18Eq9qOr1dIyRf5m/9Z56XLBnTDp5+orxNdw2GqBasYjxnbUfanYWqbIwL3KFMAQEluQ/dkCmEFA1x3CwxoM76sahpW1cs7RcrAgsirtfsVVkUCiPXKSdDBob4fHQEDbMeekH+fxYUJPpva2z18oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39840400004)(346002)(366004)(66556008)(5660300002)(52116002)(66476007)(66946007)(6486002)(186003)(8676002)(16526019)(33964004)(6666004)(31686004)(6916009)(2616005)(54906003)(966005)(7416002)(235185007)(8936002)(956004)(316002)(4001150100001)(16576012)(36756003)(86362001)(53546011)(4326008)(478600001)(2906002)(31696002)(26005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: P3EdKSUariBZaJNp0J4ssZyThFeK34HItNKQ8hy/oQBAZJHYT1YiOoyts8/dqgO3Qq0sDKrf9SZwYcdTmXm9/UCNaMUtQQMjR0uL1P4gvMjmBaSuXuhdG1E87ObCOfqQFZ6H5t7luNHHgXKLvvVvgVemUjm1Eqiedvddyp/YpgNyp620n2BDyYnYWly4VC/sHZ9Jr2istJX/luGGzdPwa4O5haSf6AUCdlnejTBY0cpE/wPtOAZWM7ruPiEAoMhz7hr8NKb+zAVeFB3bJol6I9J6vs6Hwqxvl7dnlUnqki6i24tbbxIspS3iPQ3Ci5v7o88Rbmd+LiZCD7gr6bByTkxUofN3unO2BNiD2yewtra3K/aVbAYZVVohK8QDRBnSxWnQjXegrI3VZ/axH6PWM2xQIYkFfPv7Kz9mkB9cCgzTqW3FK2pvXTVhTmzr4l2KD5tuzt8AkzuebBugwsxWJrSACXNifWxpApwuNz0sdt9f6FOmKLnXHaE+h+Av+oGVoWDV3iCg604chkxJk65hd+2HU6lLECI+lXASPH3pDcM/tmiMOWx7CHt0Pvpm/YDSnPaBEUbtYGNZ0z8ZiNOTE61RKxUzu1LW+hieLXzQR3kHBdgPTtuPiKfANVyGuuMXe6nowIhQfpQse7yTatgl8w==
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99966cd-a5ff-4c11-a704-08d88bb991f4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 12:00:41.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDp+NL4xGARWgoQyq9V45v8jdDWLNfMUnzg0rMEezSX2cOm36Ckc6waneEWvIOD1ZzQh/GXmNp0CwpgAeEC/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--------------ms050004040700050900060404
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-11-18 12:44, Borislav Petkov wrote:
> On Wed, Nov 18, 2020 at 12:18:00PM +0100, Jethro Beekman wrote:
>> Just to double check, since you didn't show the /dev mount line: that
>> is also not mounted noexec?
>=20
> Yes:
>=20
> udev on /dev type devtmpfs (rw,nosuid,noexec,relatime,size=3D8021332k,n=
r_inodes=3D2005333,mode=3D755,inode64)
>=20
> but this is how udev mounts it by default. Now I did:

On some distros, unfortunately, yes, and this breaks SGX. See https://www=
=2Espinics.net/lists/linux-sgx/msg02562.html and https://www.spinics.net/=
lists/linux-sgx/msg02617.html

>=20
> # mount /dev -o remount,exec
>=20
> and I got
>=20
> udev on /dev type devtmpfs (rw,nosuid,relatime,size=3D8021332k,nr_inode=
s=3D2005333,mode=3D755,inode64)
>=20
> and now it fails differently:
>=20
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> encl_load: encl->nr_segments: 3
> encl_load: seg2 offset: 0x3000, seg2 size: 12288
> encl_load: encl_size: 32768, src_size: 24576
> encl_map_area: encl_size: 32768
> encl_map_area: area: 0x0x7feae0db2000
> encl_map_area: encl_base: 0x7feae0db8000
> SGX_IOC_ENCLAVE_INIT failed: errno=3D1
>=20

I think that means SGX_INVALID_SIG_STRUCT, which is a very odd error to g=
et. It basically means the file header is wrong. Maybe some concurrency/f=
flush issue in the test?

--
Jethro Beekman | Fortanix


--------------ms050004040700050900060404
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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMTgxMjAwMzBaMC8GCSqGSIb3DQEJBDEiBCBw
p1myGb3rFZeJmx7jQAZElvbito2TS37q0u8dLoW4hjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG6Sa8TwYsH34Rh3zzr30OIwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBukmvE8GLB9+EYd88699DiMA0G
CSqGSIb3DQEBAQUABIIBAA60zEzkf4gjRJVuP8RgtiZyGdBUoqDk17U+0il/EbOys+0RChUq
26NCVY5uNt1rMGbiChJdfFaIydOEKcSXVZ6hPUjdvU1/qni6jJoIk0IC0/YmXft5KdZuwsDk
/3NwXURzPAQwjqqNHtTN2anMJtoHFSuv1I/AN2ebNUiVBj5wYBMCfKDPXccRNi/ObOxqFpZB
cmFpyJXDLs6CTMsBnZ06O9dj6/gg672go3agDnvFHnVSXCe98hiEuvCSYYT8RjuGOQGl8T8a
nt1kS91SAGXOWeI2L4N+gwdCdIDql5wKcSoupKVBw+M8c/2hhDZ8+vd6w9RQNhmRyMYaVSfi
rF8AAAAAAAA=

--------------ms050004040700050900060404--
