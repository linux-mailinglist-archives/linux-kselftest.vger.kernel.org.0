Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0DE3950AE
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 May 2021 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhE3LnP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 May 2021 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3LnO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 May 2021 07:43:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE207C061574
        for <linux-kselftest@vger.kernel.org>; Sun, 30 May 2021 04:41:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ot16so5035018pjb.3
        for <linux-kselftest@vger.kernel.org>; Sun, 30 May 2021 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=jhKtFLOMya17u7Yp0qZAMG+5AysNIRxXd+q8OVP04i0=;
        b=SljSY5JznA6yjU0RXPswLg+omTFJlZoF3hlexPg38QUt0uL3eDFTqQkZyGHA/sxL8m
         qwfdr+4bkL3hQ4esre9PG1OHOE9Vq5sERHFodseYcoQm5OLoZnXH7oAX2o3WJfZDEhmf
         rbWM+wK4Bvs1mCfDQZ7kEwMjol3q+y2LyMYBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=jhKtFLOMya17u7Yp0qZAMG+5AysNIRxXd+q8OVP04i0=;
        b=sjVGK6BTmUeywdoSOmu00Mo0fDqD8DATMf27ihDmiOWORsl4zpj2/tolY1CE4LHMLA
         AzTbsIAo3WQDjQAvjJ7ejmQSkcKhPzgHGueu6MuX4m7JVh4Fnk8UzMVRIaIDnPqT39lK
         vmrCJPZcIs2NaelEDU9fGSox+w749kyw2uvTClm8mVP1D89A2pHygSOetgZoQEzFIcUQ
         HDX2g5aIQrPXTZg11T5sbn9F95J/RkG1bc7T7dF6YojXTdrHptSi2G0J9tj4Z3K1/vxF
         nS7NhC0ce/SbOxSlunos7K1LQQ2KrI9Ba3x/rgLIuSY38hG8iPUzsbDnr2GCB+y+5j+a
         5+ig==
X-Gm-Message-State: AOAM5303Gm9r9Hs3VYH57JPXBZL9VTnZD9BUXkHVeHwT9mQChHMuIbDX
        6KtCTbUNs+d2H83umincv8PV6A==
X-Google-Smtp-Source: ABdhPJzgZ5P/Vi2XsqaxHoYccjYFnGrWIny2RsDSQ9KMu5WCSVV/OqlkFMYNTt6mR2h8qFTMTX4/5g==
X-Received: by 2002:a17:902:6b81:b029:ea:dcc5:b841 with SMTP id p1-20020a1709026b81b02900eadcc5b841mr15982183plk.29.1622374896303;
        Sun, 30 May 2021 04:41:36 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id o17sm8126093pjp.33.2021.05.30.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 04:41:35 -0700 (PDT)
From:   Boris Sukholitko <boris.sukholitko@broadcom.com>
To:     netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Ilya Lifshits <ilya.lifshits@broadcom.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Boris Sukholitko <boris.sukholitko@broadcom.com>
Subject: [PATCH net-next v3 1/3] net/sched: act_vlan: Fix modify to allow 0
Date:   Sun, 30 May 2021 14:40:50 +0300
Message-Id: <20210530114052.16483-2-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <20210530114052.16483-1-boris.sukholitko@broadcom.com>
References: <20210530114052.16483-1-boris.sukholitko@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000067cbad05c38a9741"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000067cbad05c38a9741
Content-Transfer-Encoding: 8bit

Currently vlan modification action checks existence of vlan priority by
comparing it to 0. Therefore it is impossible to modify existing vlan
tag to have priority 0.

For example, the following tc command will change the vlan id but will
not affect vlan priority:

tc filter add dev eth1 ingress matchall action vlan modify id 300 \
        priority 0 pipe mirred egress redirect dev eth2

The incoming packet on eth1:

ethertype 802.1Q (0x8100), vlan 200, p 4, ethertype IPv4

will be changed to:

ethertype 802.1Q (0x8100), vlan 300, p 4, ethertype IPv4

although the user has intended to have p == 0.

The fix is to add tcfv_push_prio_exists flag to struct tcf_vlan_params
and rely on it when deciding to set the priority.

Fixes: 45a497f2d149a4a8061c (net/sched: act_vlan: Introduce TCA_VLAN_ACT_MODIFY vlan action)
Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 include/net/tc_act/tc_vlan.h | 1 +
 net/sched/act_vlan.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/tc_act/tc_vlan.h b/include/net/tc_act/tc_vlan.h
index f051046ba034..f94b8bc26f9e 100644
--- a/include/net/tc_act/tc_vlan.h
+++ b/include/net/tc_act/tc_vlan.h
@@ -16,6 +16,7 @@ struct tcf_vlan_params {
 	u16               tcfv_push_vid;
 	__be16            tcfv_push_proto;
 	u8                tcfv_push_prio;
+	bool              tcfv_push_prio_exists;
 	struct rcu_head   rcu;
 };
 
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 1cac3c6fbb49..a108469c664f 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -70,7 +70,7 @@ static int tcf_vlan_act(struct sk_buff *skb, const struct tc_action *a,
 		/* replace the vid */
 		tci = (tci & ~VLAN_VID_MASK) | p->tcfv_push_vid;
 		/* replace prio bits, if tcfv_push_prio specified */
-		if (p->tcfv_push_prio) {
+		if (p->tcfv_push_prio_exists) {
 			tci &= ~VLAN_PRIO_MASK;
 			tci |= p->tcfv_push_prio << VLAN_PRIO_SHIFT;
 		}
@@ -121,6 +121,7 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 	struct tc_action_net *tn = net_generic(net, vlan_net_id);
 	struct nlattr *tb[TCA_VLAN_MAX + 1];
 	struct tcf_chain *goto_ch = NULL;
+	bool push_prio_exists = false;
 	struct tcf_vlan_params *p;
 	struct tc_vlan *parm;
 	struct tcf_vlan *v;
@@ -189,7 +190,8 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 			push_proto = htons(ETH_P_8021Q);
 		}
 
-		if (tb[TCA_VLAN_PUSH_VLAN_PRIORITY])
+		push_prio_exists = !!tb[TCA_VLAN_PUSH_VLAN_PRIORITY];
+		if (push_prio_exists)
 			push_prio = nla_get_u8(tb[TCA_VLAN_PUSH_VLAN_PRIORITY]);
 		break;
 	case TCA_VLAN_ACT_POP_ETH:
@@ -241,6 +243,7 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 	p->tcfv_action = action;
 	p->tcfv_push_vid = push_vid;
 	p->tcfv_push_prio = push_prio;
+	p->tcfv_push_prio_exists = push_prio_exists || action == TCA_VLAN_ACT_PUSH;
 	p->tcfv_push_proto = push_proto;
 
 	if (action == TCA_VLAN_ACT_PUSH_ETH) {
-- 
2.29.3


--00000000000067cbad05c38a9741
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDDSzinKpvcPTN4ZIJTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNzMwMDRaFw0yMjA5MDUwNzM3NTVaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEJvcmlzIFN1a2hvbGl0a28xLDAqBgkqhkiG
9w0BCQEWHWJvcmlzLnN1a2hvbGl0a29AYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAy/C7bjpxs+95egWV8sWrK9KO0SQi6Nxu14tJBgP+MOK5tvokizPFHoiXTymZ
7ClfnmbcqT4PzWgI3thyfk64bgUo1nQkCTApn7ov3IRsWjmHExLSNoJ/siUHagO6BPAk4JSycrj5
9tC9sL4FnIAbAHmOSILCyGyyaBAcmiyH/3toYqXyjJkK+vbWQSTxk2NlqJLIN/ypLJ1pYffVZGUs
52g1hlQtHhgLIznB1Qx3Fop3nOUk8nNpQLON/aM8K5sl18964c7aXh7YZnalUQv3md4p2rAQQqIR
rZ8HBc7YjlZynwOnZl1NrK4cP5aM9lMkbfRGIUitHTIhoDYp8IZ1dwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1ib3Jpcy5zdWtob2xpdGtvQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUtBmGs9S4
t1FcFSfkrP2LKQQwBKMwDQYJKoZIhvcNAQELBQADggEBAJMAjVBkRmr1lvVvEjMaLfvMhwGpUfh6
CMZsKICyz/ZZmvTmIZNwy+7b9r6gjLCV4tP63tz4U72X9qJwfzldAlYLYWIq9e/DKDjwJRYlzN8H
979QJ0DHPSJ9EpvSKXob7Ci/FMkTfq1eOLjkPRF72mn8KPbHjeN3VVcn7oTe5IdIXaaZTryjM5Ud
bR7s0ZZh6mOhJtqk3k1L1DbDTVB4tOZXZHRDghEGaQSnwU/qxCNlvQ52fImLFVwXKPnw6+9dUvFR
ORaZ1pZbapCGbs/4QLplv8UaBmpFfK6MW/44zcsDbtCFfgIP3fEJBByIREhvRC5mtlRtdM+SSjgS
ZiNfUggxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw0
s4pyqb3D0zeGSCUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOsKYens/WzGaZnh
pLVFvTUMsbJx2z90qx3hFEE6CfPFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIxMDUzMDExNDEzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA6mCE578UWu4WI0db1PtFpF2/wUkVF+1Gy
Jiz5h4K6xd6qvOfyUtadGeqHRxmnLZ5Gse+SWvCUErzizRRWzbjRrFDySJFlhsrXCZisMfHJkF05
naIXPDZRzucgtOBmng/J8ezVQJSr72jiYxeRjZbULLdp34lKZ7sAZQ2UWLC6fprQaUVe697TG7sc
vtGbgntBTTczAuJlmotKvqPj7cXRMZv0N+eXW7nP0FmDNv5xjDIakVF/fzGw0pzyq10724bOeYib
YBLiwB7kyUg3/Duy2wd6TzRY61+cGAai0M8nD7nnDGga9WMnNAoJovl8qW7+LLORnFNvMhXxbm9z
u0w5
--00000000000067cbad05c38a9741--
