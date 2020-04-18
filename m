Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6E1AF2CA
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDRRXb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 13:23:31 -0400
Received: from mout.web.de ([212.227.15.3]:54481 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgDRRXa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 13:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587230597;
        bh=5X9WcLil5scoD4ogMGlktyF9oZvON2fyMe52psILn1A=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=gUWzyYOqDt3bhHgBrS7/mTVD7REwUmradRWlfmi+JUrTbKk0qA5Dq7weeFOpYoXWb
         pTBhf2zUnptoc7LwbFg3aRPl7rtb4VnEopXkxK75qqPvDqXW3PL5eiKbF6eYWcXQ8f
         T1LpQB9eGzL/1k10bcBTp9XZSlwQfOBkDEzsvgN0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.116.87]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbZpT-1iwXeh3XY3-00lDLw; Sat, 18
 Apr 2020 19:23:16 +0200
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 4/4] test_kmod: Avoid potential double free in
 trigger_config_run_type()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <53bf9145-db17-9123-2489-540eaf2733a6@web.de>
Date:   Sat, 18 Apr 2020 19:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2BohLqIXxKS2n1REw16dX4v4Gs4g2i1hejGwEruRk5rAoYdYRu4
 vF0oftyf7RpN5bWomL5YNBfVzDe5oiTWDCPyndDyfudEHsiKa1z/niFO6K2wOJ6zk/sd3aE
 Dg1ecLHD2E1Z+2bYk/gmdoHlpW2dMwIqYRRznN3CzT5uf3P/9OK35HiHTS5F0WluNWj1KRg
 XrIF57H6FaU3sqU3H7u7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:js8vnVfIpgQ=:dwa4wBQT4S2QwxU6nYgFiJ
 MW00z4lPcQ1CbaSvPxIP7/jPvWvEGXfkgyn633sMTFCrJJ7+2UVurqj7/KuXFUcaIq00/mdCa
 V1zC/l6qxR5JSbtGwbt0nkH/b8THMj3lNkQWWyU22fvwRt8MoIOIZ6LFhEjEMDC9Lmqvp1u9o
 rM454q58tVW4bvGAVyJ7vMBBYjt8yEPHVPy362rH6zUsqkEcxmlqS8ua+NpED8CrmMaFQBejZ
 8nr1r8meAKd/Ax3vRbBnBahPTeJOl0WpIvzHO17md4+Z3t1x2WBlxwHCWLtOxymWPuUn1aibo
 3c+iJGk6QgUOyPJ+auWjAYHNNaMeZFhGNU82586+m3NDm2pgxWoKaF7pQ2aukH3LV/nWPEICr
 SnQtXo+A8aizQpZqBDzuNMKye4hIa9r3TE8rzOTnYaxjPi7TkOlc5IGcBXfJMYdiJiX4S0qey
 XT8U4o5YfyJgJuZyG1jKsxIxEcbKZtB+dxbTrLv4H7XeSS5cM4ZZQR7/cUjcQPcCEUIyaku9e
 9cFkCyMF9mEj7e0hScCxTyJdRXLcp6aKc9NThsMrmuylfbV0Ma1uXqEP1al/hh3i7TXuOYqnn
 JYsSY7mK9k1h5a23/MTAKD7kYctP+4hZ53/csMAsPusvmDQkjyAnYmy9CKGhjyQ+JF7+0moHJ
 xLlyin0pYeEEyvl292IRACrlej/I5cTwanpLb9SHW56ApoDTps5wG4ogd1JeAQzd3mzkiR5T4
 wHw6a7Wy613+HjNffsF/jW9DSFWwHG61CARBxM0bj66p5NS6SC6Guz9NTCsE+lGjOw1itMQv0
 5NwyY+E6njdh83Ukf/UD7OMZJ0ihjJJWPuTW5x1O7/EB3STC2s+CtFQtgVYj16tB3EjqWM9rj
 WRoOB0hvuOulDR+W/ZieZ0FKJu+2xbXy8CrdLlGfmLXJ3B/7tabg+6ezLWs6puVO+ldDRKgsG
 K3r6sTpVHYrdK6ueCWdJi1kmB3Ce2L+OJE4gAjWc4VZoxVIAWWKVPh+MJrwxj1v9w/gyqCLMD
 EgUQDpexXjy2Rs9cmm7t1bEbTRuhZ6qIZWcAagfoVWKJVU8QwKcLTS0zGxsmsNz0JXZJ9vJz9
 WkSmDWAe+nFntcX4CCo4vY82hBl4Sl+xMhtHcUZ1iNBqBnpsDnl0h2MUyQSm/PcF5ENCGjgOF
 YYrSoAdtMgebarEfHiSb7j1kCowZ9HTP3JuLS9PY4tpS2oOUMSFvRmjzHCqJBFiYfQU9gNP/K
 VvOZPrdTPBi19n7VS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> It should set config->test_fs instead of config->test_driver as NULL
> after kfree_const(config->test_fs) to avoid potential double free.

I suggest to improve this change description.

* How do you think about a wording variant like the following?

  Reset the member =E2=80=9Ctest_fs=E2=80=9D of the test configuration aft=
er a call
  of the function =E2=80=9Ckfree_const=E2=80=9D to a null pointer so that =
a double
  memory release will not be performed.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
